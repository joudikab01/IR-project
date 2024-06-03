from .utils.abbreviations import normalize_abbreviations
from .utils.apostrophe import remove_apostrophe
from .utils.date import _normalize_dates
from .utils.lemmatize import lemmatize_words
# from .utils.medical_abbreviations import replace_medical_abbreviations_text
from .utils.nomalize_number import convert_numbers, remove_commas_from_numbers
from .utils.lower import lowercase_letters
from .utils.normalize_country import _normalize_country_names
from .utils.remove_markers import remove_markers
from .utils.remove_punctuations import remove_punctuations
from .utils.remove_stopwords import remove_stopwords
from .utils.stem import stem_words
from .utils.under_score_with_space import replace_under_score_with_space


def process_text_quora(text: str) -> str:
    lowercase = lowercase_letters(text)
    # normalize_numbers = remove_commas_from_numbers(lowercase)
    # num2word = convert_numbers(normalize_numbers)
    punctuations_removed = remove_punctuations(lowercase)
    apostrophe_removed = remove_apostrophe(punctuations_removed)
    stopwords_removed = remove_stopwords(apostrophe_removed, 'quora')
    # markers_removed = remove_markers(stopwords_removed)
    # stemmed = stem_words(markers_removed)
    normalized_dates = _normalize_dates(stopwords_removed)
    normalized_country_names = _normalize_country_names(normalized_dates)
    abbreviations = normalize_abbreviations(normalized_country_names)
    lowercase = lowercase_letters(abbreviations)
    new_tokens = replace_under_score_with_space(lowercase)
    lemmatized = lemmatize_words(new_tokens)
    new_tokens = lemmatized
    return new_tokens


def process_text_clinical(text: str) -> str:
    lowercase = lowercase_letters(text)
    normalize_numbers = remove_commas_from_numbers(lowercase)
    num2word = convert_numbers(normalize_numbers)
    punctuations_removed = remove_punctuations(num2word)
    apostrophe_removed = remove_apostrophe(punctuations_removed)
    stopwords_removed = remove_stopwords(apostrophe_removed, 'clinical')
    markers_removed = remove_markers(stopwords_removed)
    # stemmed = stem_words(markers_removed)
    normalized_dates = _normalize_dates(markers_removed)
    normalized_country_names = _normalize_country_names(normalized_dates)
    abbreviations = normalize_abbreviations(normalized_country_names)
    lowercase = lowercase_letters(abbreviations)
    new_tokens = replace_under_score_with_space(lowercase)
    lemmatized = lemmatize_words(new_tokens)
    new_tokens = lemmatized
    return new_tokens
