module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);
    wire [4:0] A = {5{a}};
    wire [4:0] B = {5{b}};
    wire [4:0] C = {5{c}};
    wire [4:0] D = {5{d}};
    wire [4:0] E = {5{e}};
    
    wire [24:0] vector1 = ~{A, B, C, D, E};
    wire [24:0] vector2 = {A, B, C, D, E};
    assign out = vector1 ^ vector2;
endmodule
