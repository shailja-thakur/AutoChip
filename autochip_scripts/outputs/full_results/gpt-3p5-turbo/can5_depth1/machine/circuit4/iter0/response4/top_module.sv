module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    assign q = b | c; // Use a logical OR operation to assign the output q to the result of b OR c.
endmodule
