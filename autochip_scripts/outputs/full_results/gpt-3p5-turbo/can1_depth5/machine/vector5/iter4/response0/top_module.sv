module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [24:0] vector_1;
    wire [24:0] vector_2;
    
    assign vector_1 = {~{5{a}}, ~{5{b}}, ~{5{c}}, ~{5{d}}, ~{5{e}}};  // Fixed
    assign vector_2 = {5{a}} ^ {5{b}} ^ {5{c}} ^ {5{d}} ^ {5{e}}; // Fixed
    
    assign out = vector_1 ^ vector_2;
    
endmodule
