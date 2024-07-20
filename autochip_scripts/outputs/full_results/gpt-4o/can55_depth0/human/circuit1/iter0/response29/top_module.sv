module top_module (
    input a, 
    input b, 
    output q
);
    // The output 'q' is 1 only when both 'a' and 'b' are 1, otherwise it is 0
    assign q = a & b;
endmodule
