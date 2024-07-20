module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);
    wire [4:0] vec1_part1 = {5{a}};
    wire [4:0] vec1_part2 = {5{b}};
    wire [4:0] vec1_part3 = {5{c}};
    wire [4:0] vec1_part4 = {5{d}};
    wire [4:0] vec1_part5 = {5{e}};
    
    wire [24:0] vec1 = ~{vec1_part1, vec1_part2, vec1_part3, vec1_part4, vec1_part5}; // 25-bit vector with inverted values
    wire [24:0] vec2 = {5{a, b, c, d, e}};  // 25-bit vector with repeated values
    
    assign out = vec1 ^ vec2; // Bitwise XOR of the two 25-bit vectors
endmodule
