#include <torch/torch.h>
#include <iostream>

struct Net: torch::nn::Module{
    Net() {
        fc1 = register_module("fc1", torch::nn::Linear(784, 128));
        fc2 = register_module("fc2", torch::nn::Linear(128, 10));
    }

    torch::Tensor forward(torch::Tensor x){
        // x = fc1(x.reshape(x.size(0), 784)) input 64 batch * 1 channel * 28 * 28
        x = torch::relu(fc1->forward(x.reshape({x.size(0), 784})));
        x = fc2->forward(x);
        return torch::log_softmax(x, 1);
    }
    torch::nn::Linear fc1{nullptr}, fc2{nullptr};
};

int main(){
    auto net = std::make_shared<Net>();
    auto input = torch::randn({64, 1, 28, 28});
    auto output = net->forward(input);
    std::cout << "Output size" << output.sizes() << std::endl;
    return 0;
}