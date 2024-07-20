module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);
    wire [24:0] a_vector; // create 25-bit vector for a
    wire [24:0] b_vector; // create 25-bit vector for b
    wire [24:0] c_vector; // create 25-bit vector for c
    wire [24:0] d_vector; // create 25-bit vector for d
    wire [24:0] e_vector; // create 25-bit vector for e
    
    assign a_vector = 25'd0 - {5{a}}; // complement of 5-bit a vector
    assign b_vector = 25'd0 - {5{b}}; // complement of 5-bit b vector
    assign c_vector = 25'd0 - {5{c}}; // complement of 5-bit c vector
    assign d_vector = 25'd0 - {5{d}}; // complement of 5-bit d vector
    assign e_vector = 25'd0 - {5{e}}; // complement of 5-bit e vector
    
    assign out = a_vector ^ {5{a,b,c,d,e}}; // bitwise XOR of a_vector and {5{a,b,c,d,e}}
    
endmodule
