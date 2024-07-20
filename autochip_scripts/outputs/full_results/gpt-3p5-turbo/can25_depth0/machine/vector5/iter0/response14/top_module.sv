module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);
    wire [24:0] not_a, not_b, not_c, not_d, not_e;
    wire [24:0] vec1, vec2, xor_out;
    
    assign not_a = ~{ {5{a}} };
    assign not_b = ~{ {5{b}} };
    assign not_c = ~{ {5{c}} };
    assign not_d = ~{ {5{d}} };
    assign not_e = ~{ {5{e}} };
    
    assign vec1 = {5{a,b,c,d,e}};
    assign vec2 = {5{not_a, not_b, not_c, not_d, not_e}};
    
    assign xor_out = vec1 ^ vec2;
    assign out = xor_out;
    
endmodule
