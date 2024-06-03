from datetime import datetime
import re


def _normalize_dates(text: str) -> str:
    date_pattern = r'(\d{1,2}[-/]\d{1,2}[-/]\d{2,4})|' \
                   r'(\d{4}[-/]\d{1,2}[-/]\d{1,2})|' \
                   r'(\d{1,2}\s+(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s+\d{2,4})|' \
                   r'((Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s+\d{1,2},\s+\d{2,4})|' \
                   r'(\d{1,2}\s+(January|February|March|April|May|June|July|August|September|October|November|December)\s+\d{2,4})|' \
                   r'((January|February|March|April|May|June|July|August|September|October|November|December)\s+\d{1,2},\s+\d{2,4})'
    format_strings = ['%d-%m-%Y', '%d/%m/%Y', '%d.%m.%Y', '%Y-%m-%d', '%Y/%m/%d', '%Y.%m.%d', '%d %b %Y', '%b %d, %Y',
                      '%d %B %Y', '%B %d, %Y', '%m/%d/%Y', '%m-%d-%Y', '%m.%d.%Y', '%d-%m-%y', '%d/%m/%y', '%d.%m.%y',
                      '%y-%m-%d', '%y/%m/%d', '%y.%m.%d', '%d %b %y', '%b %d, %y',
                      '%d %B %y', '%B %d, %y', '%m/%d/%y', '%m-%d-%y', '%m.%d.%y']
    normalized_tokens = []
    for token in text.split():
        matches = re.findall(date_pattern, token)
        if matches:
            match = matches[0][0]
            for fmt in format_strings:
                try:
                    date_obj = datetime.strptime(match, fmt)
                    break
                except ValueError:
                    pass
            else:
                continue
            normalized_date = date_obj.strftime('%Y-%m-%d')
            token = token.replace(match, normalized_date)
        normalized_tokens.append(token)

    return " ".join(normalized_tokens)
