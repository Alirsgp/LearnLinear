
// The rows of C are rows of A multiplied by the matrix B
func multiplyByRows(_ A: [[Double]], _ B: [[Double]]) -> [[Double]] {
    let rowCount = A.count
    let colCount = B[0].count 
    var product: [[Double]] = Array(repeating: Array(repeating: 0.0, count: colCount), count: rowCount)
    for rowPos in 0..<rowCount {
        for colPos in 0..<colCount {
            for i in 0..<B.count {
                product[rowPos][colPos] += A[rowPos][i] * B[i][colPos]
            }
        }
    }
    return product
}

let A = [[1.0, 2.0, 3.0], [1.0, 2.0, 3.0]]

let B = [[1.0, 2.0], [1.0, 2.0], [1.0, 2.0]]

let product = multiplyByRows(A, B)

print(product)