module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

// Logic for output q (logical OR operation between inputs b and c)
assign q = b | c;

endmodule
