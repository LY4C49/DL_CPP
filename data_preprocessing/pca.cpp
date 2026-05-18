#include<vector>
#include<Eigen/Dense>

// Perform PCA to reduce data dimensions
Eigen::MatrixXd performPCA(const Eigen::MatrixXd& data, int 
numComponents) {
    Eigen::MatrixXd mean = data.colwise().mean();
    Eigen::MatrixXd centered = data.rowwise() - mean;
    Eigen::MatrixXd cov = (centered.adjoint() * centered) / 
double(data.rows() - 1);
    Eigen::SelfAdjointEigenSolver<Eigen::MatrixXd> solver(cov);
    Eigen::MatrixXd eigenvectors = solver.eigenvectors().
rightCols(numComponents);
    return centered * eigenvectors;
}