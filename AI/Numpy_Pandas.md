# Vectors, NumPy & Pandas

## Table of Contents

1. [Core Concepts](#core-concepts)
2. [NumPy Basics](#numpy-basics)
3. [Pandas Essentials](#pandas-essentials)
4. [Filtering & Subsetting](#filtering--subsetting)
5. [Sorting & Aggregation](#sorting--aggregation)
6. [Feature Engineering & Encoding](#feature-engineering--encoding)
7. [Visualization](#visualization)
8. [Quick Recap](#quick-recap)

---

## Core Concepts

| Term | Definition |
|------|-----------|
| **Scalar** | A single number |
| **Vector** | A 1D array of numbers |
| **Matrix** | A 2D array representing multiple vectors stacked together |

> **Tip:** In ML, a single data sample is a vector. A full dataset is a matrix (rows = samples, columns = features).

---

## NumPy Basics

### 1D Array

```python
import numpy as np

feature_vector = np.array([1, 2, 3, 4, 5, 6, 7])
print(f"Feature shape: {feature_vector.shape}")  # (7,) -> 7 elements, 1 dimension
```

### 2D Array

```python
data_matrix = np.array([
    [1, 2, 3],
    [4, 5, 6]
])
print(f"Data matrix shape: {data_matrix.shape}")  # (2, 3) -> 2 rows, 3 columns
```

### Dot Product

```python
v1 = np.array([1, 2, 3])
v2 = np.array([4, 5, 6])

dot_product = np.dot(v1, v2)  # 1*4 + 2*5 + 3*6 = 32
```

> **Note:** The dot product is the foundation of linear regression and many neural network operations — it measures how much two vectors "align."

---

## Pandas Essentials

### Loading Data

```python
from sklearn.datasets import load_iris
import pandas as pd

iris = load_iris(as_frame=True)
df_raw = iris.frame
df = df_raw.copy()
```

### Inspecting Data

| Function | What it does |
|----------|-------------|
| `df.head()` | First 6 rows |
| `df.tail()` | Last 6 rows |
| `df.info()` | Column types, non-null counts, memory usage |
| `df.shape` | Tuple of (rows, columns) — attribute, not a method |
| `df.columns` | Array of column names — attribute, not a method |
| `df.describe()` | Count, mean, std, min, 25%, 50%, 75%, max per column |
| `df['target'].value_counts()` | Count of each unique value in a column |

> **Common Mistake:** `df.shape` and `df.columns` are **attributes**, not methods — don't add `()`.

### Handling Missing Data

```python
df.isnull().sum()   # count null values per column
df.dropna()         # remove rows with any null values
df.fillna(0)        # replace null values with 0
```

### Quick Visualization from Data

```python
df['sepal_length (cm)'].hist()  # histogram of a single column
```

### Converting to Python List

```python
sepal_length = df['sepal_length (cm)']
print(sepal_length.to_list())
```

---

## Filtering & Subsetting

### Boolean Filtering with `.loc`

```python
# rows where sepal length > 6.0
large_sepals = df.loc[df['sepal_length (cm)'] > 6.0]
print(large_sepals.head())
```

### Filtering by Category

```python
# subset for setosa (target == 0)
setosa_sub = df[df['target'] == 0]
print(setosa_sub.head())
```

### Slicing Rows and Columns with `.iloc`

```python
# rows 0-4, columns 0-2 (integer-based indexing)
subset = df.iloc[0:5, 0:3]
print(subset)
```

> **Note:** `.loc` is label-based (use column names and conditionals). `.iloc` is integer position-based (use row/col indices).

```mermaid
flowchart LR
    A[Need to filter data] --> B{Label or Position?}
    B -->|Label / Condition| C[df.loc[rows, cols]]
    B -->|Integer Index| D[df.iloc[rows, cols]]
```

---

## Sorting & Aggregation

### Sorting

```python
df.sort_values(by='sepal_length (cm)')                         # ascending (default)
df.sort_values(by='sepal_length (cm)', ascending=False)         # descending
```

> **Common Mistake:** The parameter is `ascending` (not `ascesding`).

### Grouping & Aggregation

```python
df.groupby('target').mean()                  # mean per group
df.groupby('target').agg(['mean', 'std'])    # mean and std per group
```

> **Note:** `.agg()` takes a **list** of aggregation function names, not separate arguments.

---

## Feature Engineering & Encoding

### Creating a New Column

```python
df['sepal_ratio'] = df['sepal_length (cm)'] / df['sepal_width (cm)']
df.head()
```

### Mapping / Encoding

```python
# map target integers to species names
df['species'] = df['target'].map({0: 'setosa', 1: 'versicolor', 2: 'virginica'})

# or map species names to integers
df['encoded_species'] = df['species'].map({'setosa': 0, 'versicolor': 1, 'virginica': 2})
```

### Cross-Tabulation

```python
pd.crosstab(df['species'], df['sepal_length (cm)'] > 5.0)
```

> **Note:** `pd.crosstab` is useful for quickly checking the relationship between two categorical variables.

---

## Visualization

### Histogram (Distribution by Group)

```python
import matplotlib.pyplot as plt

plt.figure(figsize=(10, 4))
for species in df['species'].unique():
    subset = df[df['species'] == species]
    plt.hist(subset['sepal_length (cm)'], alpha=0.5, bins=15, label=species)

plt.title('Histogram of Sepal Length by Species')
plt.xlabel('Sepal Length (cm)')
plt.ylabel('Frequency')
plt.legend()
plt.show()
```

### Boxplot (Spread & Outliers)

```python
plt.figure(figsize=(8, 5))
df.boxplot(column='petal width (cm)', by='species', grid=False)
plt.title('Boxplot of Petal Width by Species')
plt.suptitle('')  # suppress the automatic group title
plt.xlabel('Species')
plt.ylabel('Petal Width (cm)')
plt.show()
```

> **Common Mistake:** `plt.suptitle('')` removes the auto-generated title that `df.boxplot(by=...)` adds. `plt.title()` alone won't override it.

### Scatter Plot (Two Continuous Variables)

```python
colors = {'setosa': 'red', 'versicolor': 'green', 'virginica': 'blue'}
plt.figure(figsize=(10, 4))
for species, color in colors.items():
    subset = df[df['species'] == species]
    plt.scatter(
        subset['petal_length (cm)'],
        subset['petal_width (cm)'],
        alpha=0.7,
        color=color,
        label=species
    )

plt.title('Petal Length vs Petal Width')
plt.xlabel('Petal Length (cm)')
plt.ylabel('Petal Width (cm)')
plt.legend()
plt.show()
```

> **Common Mistake:** Use `.items()` not `.item()` when iterating over a dictionary.

---

## Quick Recap

- **Scalars** are single numbers, **vectors** are 1D arrays, **matrices** are 2D arrays.
- `numpy.array()` creates vectors/matrices; `.shape` gives dimensions; `np.dot()` computes dot products.
- **Pandas loading:** `load_iris(as_frame=True)` gives you a DataFrame directly.
- **Inspection:** `head()`, `info()`, `describe()`, `value_counts()` — use them first on any new dataset.
- **Missing data:** `isnull().sum()` to find it, `dropna()` or `fillna()` to handle it.
- **`df.shape` and `df.columns`** are attributes — no parentheses.
- **Filtering:** `.loc` for labels/conditions, `.iloc` for integer positions.
- **Sorting:** `ascending=False` for descending — watch the spelling.
- **Groupby + agg:** `.agg(['mean', 'std'])` — pass a list, not separate args.
- **Encoding:** `.map()` converts between categorical labels and numeric codes.
- **Plots:** `hist()` for distributions, `boxplot()` for spread/outliers, `scatter()` for two-variable relationships.
- **Dictionary iteration:** `colors.items()`, not `colors.item()`.
