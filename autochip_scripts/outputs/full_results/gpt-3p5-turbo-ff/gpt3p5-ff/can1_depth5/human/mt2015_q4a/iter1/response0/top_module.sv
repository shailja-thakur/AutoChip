module top_module(
    input x,
    input y,
    output z);
    
    // Declare internal wire
    wire w1;
    
    // xor gate between x and y
    xor XOR1 (.a(x), .b(y), .o(w1));
    
    // AND gate between w1 and x
    and AND1 (.a(w1), .b(x), .o(z));
    
endmodule
module xor (
    input a,
    input b,
    output o
);
    assign o = a ^ b;
endmodule
module and (
    input a,
    input b,
    output o
);
    assign o = a & b;
endmodule
