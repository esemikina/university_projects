import numpy as np

# Global dictionaries for character to ID and ID to character mapping
char_to_id = {}
id_to_char = {}

def _update_vocab(txt):
    """
    Updates the global char_to_id and id_to_char dictionaries with new characters.
    """
    for char in txt:
        if char not in char_to_id:
            tmp_id = len(char_to_id)
            char_to_id[char] = tmp_id
            id_to_char[tmp_id] = char

def get_vocab():
    """
    Returns the global char_to_id and id_to_char dictionaries.
    """
    return char_to_id, id_to_char

def load_data(file_path, reverse=False, max_length=None, train_test_split=0.8):
    """
    Load and preprocess data from the file for training the GRU-based PeekySeq2seq model.
    Splits the data into training and testing sets.
    """
    questions, answers = [], []

    with open(file_path, 'r') as file:
        lines = file.readlines()

    if max_length is None:
        max_length = max(len(line.strip().replace(' ', '')) for line in lines)

    for line in lines:
        parts = line.strip().split(' ')
        if len(parts) != 2:
            continue

        question, answer = parts
        _update_vocab(question + answer)

        question_ids = [char_to_id[c] for c in question]
        answer_ids = [char_to_id[c] for c in answer]

        if reverse:
            question_ids = question_ids[::-1]

        question_ids = np.pad(question_ids, (0, max_length - len(question_ids)), 'constant')
        answer_ids = np.pad(answer_ids, (0, max_length - len(answer_ids)), 'constant')

        questions.append(question_ids)
        answers.append(answer_ids)

    # Splitting the data into training and testing sets
    split_index = int(len(questions) * train_test_split)
    x_train, x_test = questions[:split_index], questions[split_index:]
    t_train, t_test = answers[:split_index], answers[split_index:]

    return (np.array(x_train), np.array(t_train)), (np.array(x_test), np.array(t_test))