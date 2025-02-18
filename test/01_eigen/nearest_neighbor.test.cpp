#include <iostream>
#include <Eigen/Dense>

using namespace Eigen;

// ref: https://qiita.com/shiro-kuma/items/0faa02aa064a3c0a460b
int main() {
  Eigen::MatrixXf m(2,4);
  Eigen::VectorXf v(2);

  m << 1, 23, 6, 9,
       3, 11, 7, 2;

  v << 2,
       3;

  MatrixXf::Index index;
  (m.colwise() - v).colwise().squaredNorm().minCoeff(&index);

  std::cout << "Nearest neighbor is column " << index << ":" << std::endl;
  std::cout << m.col(index) << std::endl;
}
