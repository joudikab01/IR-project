enum Dataset {
  quora,
  clinical;

  @override
  String toString() {
    switch (this) {
      case Dataset.quora:
        return "Quora";
      case Dataset.clinical:
        return "Clinical Trials";
    }
  }

  String toJson() {
    switch (this) {
      case Dataset.quora:
        return "quora";
      case Dataset.clinical:
        return "clinical";
    }
  }

  String toChar() {
    switch (this) {
      case Dataset.quora:
        return "Q";
      case Dataset.clinical:
        return "C";
    }
  }
}
