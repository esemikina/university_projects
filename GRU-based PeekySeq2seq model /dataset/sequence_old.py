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

def load_data(file_path, reverse=False):
    """
    Load and preprocess data from the file for training the GRU-based PeekySeq2seq model.
    Pads both questions and answers to the length of the shortest sequence in the dataset.
    """
    questions, answers = [], []

    with open(file_path, 'r') as file:
        lines = file.readlines()

    # Find the length of the shortest sequence in the dataset
    shortest_length = min(len(line.strip().replace(' ', '')) for line in lines)

    for line in lines:
        question, answer = line.strip().split(' ')
        _update_vocab(question + answer)

        question_ids = [char_to_id[c] for c in question]
        answer_ids = [char_to_id[c] for c in answer]

        if reverse:
            question_ids = question_ids[::-1]

        # Pad both question and answer to the shortest length
        question_ids = np.pad(question_ids, (0, shortest_length - len(question_ids)), 'constant')
        answer_ids = np.pad(answer_ids, (0, shortest_length - len(answer_ids)), 'constant')

        questions.append(question_ids)
        answers.append(answer_ids)
    return np.array(questions), np.array(answers)

