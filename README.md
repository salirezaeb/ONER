
# 🌳 Decision Tree Classification – MATLAB Implementation

This project presents a machine learning classification system built around a custom **decision tree** algorithm. It is implemented in MATLAB and designed to classify data with both numeric and categorical features. The model is trained and validated using cross-validation to ensure robust performance.

---

## 📁 Dataset

- **Filename**: `injury2.xlsx`
- The dataset contains both numerical and categorical columns.
- The first row contains header labels.
- Some numeric fields may initially appear as strings and are converted during preprocessing.

---

## 🧪 Data Preparation Steps

### 1. **Loading & Cleaning**
- Data is loaded using `xlsread`, returning:
  - `num` – numerical data
  - `str` – string/categorical data
  - `row` – combined original data
- Header row is removed.
- Labels are extracted.
- Numeric strings in the 10th column are converted to actual numbers.

### 2. **Feature Identification**
- Features are classified into:
  - `o1`: Numeric features
  - `o2`: Categorical features

### 3. **Cross-Validation Partitioning**
- Dataset is split into **5 equal folds**:
  - Each fold: 80% training, 20% testing
  - Ensures random sampling without overlap

---

## 🧩 Model Construction

### 4. **Unique State Identification**
- For each categorical feature, unique states (values) are identified and counted.

### 5. **Class-Based Data Separation**
- Training data is divided into subsets by class labels.

### 6. **Probability Tables**
- For **categorical features**, probability tables are created:
  - Frequency of each category per class
  - Used for conditional probability during classification

### 7. **Decision Tree Building**
- Separate tree logic for:
  - Categorical: based on frequency/probability splits
  - Numeric: uses thresholds for branching
- Trees are built per fold for evaluation

---

## 🧠 Prediction & Evaluation

### 8. **Prediction**
- Labels for test data are predicted using the built trees.

### 9. **Error Calculation**
- Accuracy and error for each fold are computed.
- Final metric: **mean prediction error** across all folds

---

## 📊 Saved Variables

| Variable       | Description                                      |
|----------------|--------------------------------------------------|
| `mianginkhata` | Mean error over all folds                        |
| `finaltree`    | Trained decision tree model                      |
| `predictlabel` | Model's predicted labels on test data            |
| `actuallabel`  | True labels from test data                       |
| `testeror`     | Per-fold error values                            |

---

## ✅ Strengths

- Handles both **numeric and categorical features**
- Uses **cross-validation** for reliable error estimation
- Stores full results for post-analysis and visualization

---

## 📄 License

MIT License – For academic, research, and educational usage.

---

## 👨‍💻 Author

This work was developed as part of a machine learning curriculum, focused on custom implementation and validation of decision tree-based classification in MATLAB.

