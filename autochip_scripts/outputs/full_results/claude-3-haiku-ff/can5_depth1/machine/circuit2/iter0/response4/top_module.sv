module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

wire [3:0] inputs;
assign inputs = {a, b, c, d};

// Using reduce XOR to perform the bitwise XOR operation
assign q = ~^inputs;

endmodule
