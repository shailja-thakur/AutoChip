module top_module (
    input a, 
    input b, 
    input c, 
    input d, 
    output q
);
    // Implementing the OR gate using the OR operator
    assign q = b | c;
endmodule
