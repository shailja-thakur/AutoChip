module top_module (
    input a, 
    input b, 
    output q
);
    // q is true only when both a and b are true (logical AND)
    assign q = a & b;
endmodule
