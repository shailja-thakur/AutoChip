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
    
    wire [24:0] vector_1 = {{5{~a}}, {5{~b}}, {5{~c}}, {5{~d}}, {5{~e}}};  // Fixed
    wire [24:0] vector_2 = {{5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}}};  // Fixed
    
    assign out = vector_1 ^ vector_2;
    
endmodule
