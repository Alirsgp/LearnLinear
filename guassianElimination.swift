import Foundation

func printMatrix(matrix: [[Double]]) {
    for row in matrix {
        for element in row {
            print(String(format: "%.2f ", element), terminator: "")
        }
        print()
    }
}

func backSub(matrix: inout [[Double]]) {
    let unknowns = matrix.count
    var x: [Double] = [Double](repeating: 0.0, count: unknowns)
    
    /**
    Start calculating from last equation up to the first
    **/
    for i in (0...(unknowns - 1)).reversed() {
        // Start with RHS of the equation
       x[i] = matrix[i][unknowns]
       // Init j to i + 1 since matrix is upper triangular
       for j in (i + 1)..<unknowns {
           // Subtract all the LHS values,
           // except the coefficient of the variable
           // whos value is being calculated
           let subtractedBy = matrix[i][j] * x[j]
           x[i] -= subtractedBy
       }

       // Divide the RHS by the coefficient of the unknown being calculated
       x[i] = x[i] / matrix[i][i]
    }
    print("Solution set:")
    for i in 0..<unknowns {
        print(String(format: "%.2f ", x[i]), terminator: "")
    }
    print()
}

func guassianElimination(matrix: inout [[Double]]) {
    let forwardEliminationOutput = forwardElimination(matrix: &matrix)
    let isSingular = forwardEliminationOutput != -1;
    if (isSingular) {
        print("Encountered singular matrix")
        /**
        if RHS of equation corresponding to zero row is 0, system has 
        infinitely many solutions, otherwise system is inconsistent
        **/
        if (matrix[forwardEliminationOutput][matrix.count] != 0) {
            print("Inconsistent system")
        } else {
            print("Infinitely many solutions")
        }
        return
    }
    print("Matrix is non-singular \(isSingular)")
    // get solution to system and print it using back sub
    backSub(matrix: &matrix)

}

func swap_row(matrix: inout [[Double]], i: Int, j: Int) {
    for k in 0...matrix.count {
        let temp = matrix[i][k]
        matrix[i][k] = matrix[j][k]
        matrix[j][k] = temp
    }
}

// // Reduce the matrix to row echelon form, return -1 if matrix is singular
func forwardElimination(matrix: inout [[Double]]) -> Int {
    let unknowns = matrix.count
    for k in 0..<unknowns {
        // Initialize max value and index for pivot
        var iMax = k
        var vMax = Int(matrix[iMax][k])

        // Find greater amplitude for pivot if any
        for i in (k + 1)..<unknowns {
            if (Int(abs(matrix[i][k])) > vMax) {
                vMax = Int(matrix[i][k])
                iMax = i
            }
        }

        /** 
        If principal diagonal elemnt is zero, denotes matrix is singular,
        and will lead to division by zero later
        **/
        if (matrix[k][iMax] == 0) {
            return k
        }

        /**
        Swap the greatest value row with current row
        **/
        if (iMax != k) {
            swap_row(matrix: &matrix, i: k, j: iMax)
        }

        for i in (k + 1)..<unknowns {
            /**
            factor f to set current row kth element to 0, subsequently remaining kth column to 0
            **/
            let f = matrix[i][k] / matrix[k][k]
            print("f is \(f)")
            // Subtract fth multiple of corresponding kth row element
            for j in (k + 1)...unknowns {
                let subtractBy = matrix[k][j] * f
                print("subtract by \(subtractBy)")
                matrix[i][j] -= subtractBy 
                print("value is \(matrix[i][j])")
            }

            // Filling lower triangular matrix with zeros
            matrix[i][k] = 0
        }

    }
    print("After forward elimination")
    printMatrix(matrix: matrix)
    print("------------------------------")
    return -1
}

var inputAugmentedMatrix: [[Double]] = [
    [1.0, 2, 3, 8.0],
    [4, 5, 6, 12],
    [5, 7, 8, 13]
]

printMatrix(matrix: inputAugmentedMatrix)

print("------------------------------")

guassianElimination(matrix: &inputAugmentedMatrix)

