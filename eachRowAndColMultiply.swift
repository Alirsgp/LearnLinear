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

// CAN ONLY ADD TWO MATRICES OF THE SAME DIMENSION
func addTwoMatrices(_ A: [[Double]], _ B: [[Double]]) -> [[Double]] {
    let rowCountA = A.count 
    let colCountB = B[0].count 
    var matrixSum: [[Double]] = Array(repeating: Array(repeating: 0.0, count: colCountB), count: rowCountA)
    for rowPos in 0..<rowCountA {
        for colPos in 0..<colCountB {
            matrixSum[rowPos][colPos] += A[rowPos][colPos] + B[rowPos][colPos]
        }
    }
    return matrixSum
}

// Take each row of A, each col of B, and multiply them accordingly, then add them all up
func multiplyEachRowAndCol(_ A: [[Double]], _ B: [[Double]]) -> [[Double]] {
    let rowCountA = A.count 
    let colCountB = B[0].count
    let rowCountB = B.count

    var product: [[Double]] = Array(repeating: Array(repeating: 0.0, count: colCountB), count: rowCountA)
    var productColumnA: [[Double]] =  Array(repeating: Array(repeating: 0.0, count: 1), count: rowCountA) 
    var eachRowB: [Double] = Array(repeating: 0.0, count: colCountB)

    for rowOfB in 0..<rowCountB {
        for i in 0..<colCountB {
            eachRowB[i] = B[rowOfB][i]
            productColumnA[i][0] = A[i][rowOfB]
        }
        let productOfColAndRow = multiplyByRows(productColumnA, [eachRowB])
        product = addTwoMatrices(product, productOfColAndRow)
    }

    return product
}


let A = [[1.0, 2.0, 3.0], [1.0, 2.0, 3.0]]

let B = [[1.0, 2.0], [1.0, 2.0], [1.0, 2.0]]

let product = multiplyEachRowAndCol(A, B)

print(product)

let C = [[1.0, 2.0], [3.0, 4.0]]
let D = [[1.0, 2.0], [3.0, 4.0]]

