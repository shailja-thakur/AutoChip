module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    wire out;

    assign out = ~(a ^ b ^ c ^ d);
    assign q = out;

endmodule
