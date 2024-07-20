module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [4:0] not_a = ~a;
    wire [4:0] not_b = ~b;
    wire [4:0] not_c = ~c;
    wire [4:0] not_d = ~d;
    wire [4:0] not_e = ~e;
    
    wire [4:0] a_bit = ~a;
    wire [4:0] b_bit = ~b;
    wire [4:0] c_bit = ~c;
    wire [4:0] d_bit = ~d;
    wire [4:0] e_bit = ~e;
    
    wire [24:0] vector_1 = {{5{not_a}}, {5{not_b}}, {5{not_c}}, {5{not_d}}, {5{not_e}}};
    wire [24:0] vector_2 = {{5{a_bit}}, {5{b_bit}}, {5{c_bit}}, {5{d_bit}}, {5{e_bit}}};
    
    assign out = vector_1 ^ vector_2;

endmodule
