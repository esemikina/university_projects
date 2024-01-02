import sys
import os
import numpy

id_to_char = {}
char_to_id = {}

def _update_vocab(txt):
    chars = list(txt)
    for i, char in enumerate(chars):
        if char not in char_to_id:
            tmp_id = len(char_to_id)
            char_to_id[char] = tmp_id
            id_to_char[tmp_id] = char

def load_data(file_name='addition.txt', seed=1984):
    file_path = os.path.dirname(os.path.abspath(__file__)) + '/' + file_name

    if not os.path.exists(file_path):
        print('No file: %s' % file_name)
        return None

    questions, answers = [], []
    for line in open(file_path, 'r'):
        idx = line.find('_')
        questions.append(line[:idx].strip())  # Strip to remove whitespaces
        answers.append(line[idx+1:].strip())  # Strip and skip underscore

    # Create vocab dict
    for q, a in zip(questions, answers):
        _update_vocab(q)
        _update_vocab(a)

    # Determine max lengths for questions and answers separately
    max_len_questions = max(len(q) for q in questions)
    max_len_answers = max(len(a) for a in answers)

    # Create numpy arrays with padding
    x = numpy.zeros((len(questions), max_len_questions), dtype=numpy.int32)
    t = numpy.zeros((len(answers), max_len_answers), dtype=numpy.int32)

    for i, sentence in enumerate(questions):
        padded_sentence = sentence + ' ' * (max_len_questions - len(sentence))
        x[i] = [char_to_id[c] for c in list(padded_sentence)]

    for i, sentence in enumerate(answers):
        padded_sentence = sentence + ' ' * (max_len_answers - len(sentence))
        try:
            t[i] = [char_to_id[c] for c in list(padded_sentence)]
        except ValueError as e:
            print(f"Error at index {i}: '{sentence}' -> '{padded_sentence}'")
            print(f"Expected length: {max_len_answers}, Actual list length: {len([char_to_id[c] for c in list(padded_sentence)])}")
            raise e

    # Shuffle
    indices = numpy.arange(len(x))
    if seed is not None:
        numpy.random.seed(seed)
    numpy.random.shuffle(indices)
    x = x[indices]
    t = t[indices]

    # Split data for training and testing
    split_at = len(x) - len(x) // 10
    (x_train, x_test) = x[:split_at], x[split_at:]
    (t_train, t_test) = t[:split_at], t[split_at:]

    return (x_train, t_train), (x_test, t_test)


def get_vocab():
    return char_to_id, id_to_char
