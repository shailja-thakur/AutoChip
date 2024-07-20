module top_module (
    input a,
    input b,
    output sum,
    output cout
);

// Half Adder Logic
assign sum = a ^ b;
assign cout = a & b;

endmodule
