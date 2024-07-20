module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

wire x1, x2;

assign x1 = a ^ b;
assign x2 = c ^ d;
assign q = ~(x1 ^ x2);

endmodule
