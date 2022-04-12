
// Each column of C is the matrix A multiplied by a column of B. Effect of this is that the columns of C 
// are linear combinations of the columns of A with weights given by columns of B
func multiplyByColumns(_ A: [[Double]], _ B: [[Double]]) -> [[Double]] {
    let colCountA = A[0].count 
    let rowCountA = A.count 
    let colCountB = B[0].count

    var product: [[Double]] = Array(repeating: Array(repeating: 0.0, count: colCountB), count: rowCountA)

    // #1 Get the multiple of b, reading from column down
    for colPosB in 0..<colCountB {
        // #2. Get each column of A
        var productColumn: [Double] = Array(repeating: 0.0, count: rowCountA)
        for colPosA in 0..<colCountA {
            let bMultiple = B[colPosA][colPosB]
            for rowPosA in 0..<rowCountA {
                productColumn[rowPosA] = A[rowPosA][colPosA] * bMultiple
            }
            for i in 0..<productColumn.count {
                product[i][colPosB] += productColumn[i]
            }
        }
    }
    return product
}


let A = [[1.0, 2.0, 3.0], [1.0, 2.0, 3.0]]

let B = [[1.0, 2.0], [1.0, 2.0], [1.0, 2.0]]

let product = multiplyByColumns(A, B)

print(product)