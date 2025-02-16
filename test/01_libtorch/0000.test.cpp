// ref: https://pytorch.org/cppdocs/installing.html

#ifdef __clang__


#pragma message("skipped")

int main() {}


#else


#include <torch/torch.h>
#include <iostream>

int main() {
  torch::Tensor tensor = torch::rand({2, 3});
  std::cout << tensor << std::endl;
}


#endif
