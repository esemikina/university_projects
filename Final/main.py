import pandas as pd
from sklearn.model_selection import train_test_split
import re
import nltk
from nltk.tokenize import word_tokenize
from collections import Counter
from keras.preprocessing.sequence import pad_sequences
import matplotlib.pyplot as plt
import numpy as np
import torch
import torch.nn as nn
from torch.utils.data import DataLoader, TensorDataset
import torch.optim as optim
import torch.nn.functional as F

class SentimentClassifier(nn.Module):
    def __init__(self, vocab_size, embedding_dim, hidden_dim, output_dim):
        super(SentimentClassifier, self).__init__()
        self.embedding = nn.Embedding(vocab_size, embedding_dim)
        self.fc = nn.Linear(embedding_dim, hidden_dim)
        self.relu = nn.ReLU()
        self.out = nn.Linear(hidden_dim, output_dim)
        self.sigmoid = nn.Sigmoid()

    def forward(self, x):
        embedded = self.embedding(x)
        hidden = self.fc(embedded.mean(dim=1))
        hidden = self.relu(hidden)
        output = self.out(hidden)
        return self.sigmoid(output)


# Load dataset
df = pd.read_csv('./imdb.csv')

# Splitting the dataset into training, validation, and testing sets
train_df, temp_df = train_test_split(df, test_size=0.3, random_state=42)  # 70% training, 30% for val and test
val_df, test_df = train_test_split(temp_df, test_size=0.5, random_state=42)  # Split the 30% into 15% val and 15% test

# Cleaning Data
def clean_text(text):
    # Add whitespace around punctuation
    text = re.sub(r'([.,!?()])', r' \1 ', text)
    # Remove non-punctuation symbols
    text = re.sub(r'[^a-zA-Z.,!?() ]', '', text)
    return text.strip()

# Apply cleaning to all splits
train_df['cleaned_text'] = train_df['review'].apply(clean_text)
val_df['cleaned_text'] = val_df['review'].apply(clean_text)
test_df['cleaned_text'] = test_df['review'].apply(clean_text)

# Map string labels to numeric values: 'negative' to 0 and 'positive' to 1
label_map = {'negative': 0, 'positive': 1}
train_df['sentiment'] = train_df['sentiment'].map(label_map).astype(float)
val_df['sentiment'] = val_df['sentiment'].map(label_map).astype(float)
test_df['sentiment'] = test_df['sentiment'].map(label_map).astype(float)


# Download NLTK tokenizer model
nltk.download('punkt')

# Tokenization
tokenized_reviews = [word_tokenize(review.lower()) for review in train_df['cleaned_text']]
val_tokenized = [word_tokenize(review.lower()) for review in val_df['cleaned_text']]
test_tokenized = [word_tokenize(review.lower()) for review in test_df['cleaned_text']]

# Build Vocabulary
word_counts = Counter(word for review in tokenized_reviews for word in review)
vocabulary = {word: i + 1 for i, (word, _) in enumerate(word_counts.most_common(10000))}

# Convert Text to Integer Sequences
reviews_int = [[vocabulary[word] for word in review if word in vocabulary] for review in tokenized_reviews]
val_reviews_int = [[vocabulary[word] for word in review if word in vocabulary] for review in val_tokenized]
test_reviews_int = [[vocabulary[word] for word in review if word in vocabulary] for review in test_tokenized]
review_lengths = [len(review) for review in tokenized_reviews]

# Find a suitable max length
percentile = 95
max_len = int(np.percentile(review_lengths, percentile))

# Padding Sequences
padded_reviews = pad_sequences(reviews_int, maxlen=max_len, padding='post', truncating='post')
val_padded_reviews = pad_sequences(val_reviews_int, maxlen=max_len, padding='post', truncating='post')
test_padded_reviews = pad_sequences(test_reviews_int, maxlen=max_len, padding='post', truncating='post')


# Parameters
vocab_size = 10000 + 1 # +1 for padding token
embedding_dim = 100  # common choice for embedding dimension
hidden_dim = 64 # mid-range for hidden dimension
output_dim = 1 # binary

# init model
model = SentimentClassifier(vocab_size, embedding_dim, hidden_dim, output_dim)

# Parameters
batch_size = 32  # You can adjust the batch size

train_inputs = torch.tensor(padded_reviews, dtype=torch.long)
val_inputs = torch.tensor(val_padded_reviews, dtype=torch.long)
test_inputs = torch.tensor(test_padded_reviews, dtype=torch.long)

# labels
train_labels = torch.tensor(train_df['sentiment'].values, dtype=torch.float32)
val_labels = torch.tensor(val_df['sentiment'].values, dtype=torch.float32)
test_labels = torch.tensor(test_df['sentiment'].values, dtype=torch.float32)

# Train DataLoader
train_data = TensorDataset(train_inputs, train_labels)
train_loader = DataLoader(train_data, batch_size=batch_size, shuffle=True)

# Validation DataLoader
val_data = TensorDataset(val_inputs, val_labels)
val_loader = DataLoader(val_data, batch_size=batch_size, shuffle=True)

# Test DataLoader
test_data = TensorDataset(test_inputs, test_labels)
test_loader = DataLoader(test_data, batch_size=batch_size, shuffle=False)


# Define optimizer and loss function
optimizer = optim.Adam(model.parameters(), lr=0.001)
criterion = nn.BCELoss()

num_epochs = 8

for epoch in range(num_epochs):
    # Training Phase
    model.train()
    total_loss, total, correct = 0, 0, 0

    for inputs, labels in train_loader:
        optimizer.zero_grad()
        outputs = model(inputs)
        loss = criterion(outputs.squeeze(), labels)
        loss.backward()
        optimizer.step()

        total_loss += loss.item()
        predicted = (outputs.squeeze() > 0.5).float()
        correct += (predicted == labels).sum().item()
        total += labels.size(0)

    train_loss = total_loss / len(train_loader)
    train_accuracy = correct / total
    print(f'Epoch {epoch+1}/{num_epochs}, Train Loss: {train_loss:.4f}, Train Accuracy: {train_accuracy:.4f}')

    # Validation Phase
    model.eval()
    val_loss, val_correct, val_total = 0, 0, 0
    with torch.no_grad():
        for inputs, labels in val_loader:
            outputs = model(inputs)
            loss = criterion(outputs.squeeze(), labels)
            val_loss += loss.item()
            predicted = (outputs.squeeze() > 0.5).float()
            val_correct += (predicted == labels).sum().item()
            val_total += labels.size(0)

    val_loss /= len(val_loader)
    val_accuracy = val_correct / val_total
    print(f'Epoch {epoch+1}/{num_epochs}, Validation Loss: {val_loss:.4f}, Validation Accuracy: {val_accuracy:.4f}')

# Model Testing
model.eval()
test_loss, test_correct, test_total = 0, 0, 0

with torch.no_grad():
    for inputs, labels in test_loader:
        outputs = model(inputs)
        loss = criterion(outputs.squeeze(), labels)
        test_loss += loss.item()
        predicted = (outputs.squeeze() > 0.5).float()
        test_correct += (predicted == labels).sum().item()
        test_total += labels.size(0)

test_loss /= len(test_loader)
test_accuracy = test_correct / test_total
print(f'Test Loss: {test_loss:.4f}, Test Accuracy: {test_accuracy:.4f}')


# Extract the embedding layer weights
embedding_weights = model.embedding.weight.data

# Calculate the influence of each word
word_influence = torch.norm(embedding_weights, dim=1)

# Create a dictionary of words and their corresponding influence
word_influence_dict = {word: influence.item() for word, influence in zip(vocabulary, word_influence)}

# Sort words by influence
sorted_words = sorted(word_influence_dict.items(), key=lambda x: x[1], reverse=True)

# Get top 20 influential words for positive and negative reviews
# Assuming higher values indicate positive influence and lower values indicate negative
top_positive_words = sorted_words[:20]
top_negative_words = sorted_words[-20:]

# Print top 5 influential words for positive reviews
print("Top 20 Positive Words:")
for word, influence in top_positive_words[:20]:
    print(f"{word}: {influence}")

# Print top 10 influential words for negative reviews
print("\nTop 20 Negative Words:")
for word, influence in top_negative_words[:20]:
    print(f"{word}: {influence}")