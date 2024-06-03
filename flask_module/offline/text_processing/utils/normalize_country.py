import pycountry


def _normalize_country_names(text: str) -> str:
    normalized_tokens = []
    for token in text.split():
        upper_token = token.upper()
        country_name = None

        # Try to lookup by alpha-2 code
        country = pycountry.countries.get(alpha_2=upper_token)
        if not country:
            # Try to lookup by alpha-3 code if alpha-2 lookup fails
            country = pycountry.countries.get(alpha_3=upper_token)

        if country:
            country_name = country.name

        # Append the found country name or the original token if not found
        normalized_tokens.append(country_name if country_name else token)

    return " ".join(normalized_tokens)

