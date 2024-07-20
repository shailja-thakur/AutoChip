module top_module (
    input a, 
    input b, 
    output q
);
    assign q = a & b;  // Perform logical AND operation between inputs a and b and assign to output q
endmodule
