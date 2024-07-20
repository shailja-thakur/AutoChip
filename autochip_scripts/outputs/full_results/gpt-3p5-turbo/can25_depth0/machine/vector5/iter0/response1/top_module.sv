module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);
    
    wire [4:0] not_a, not_b, not_c, not_d, not_e;
    wire [24:0] concat_a, concat_b, concat_c, concat_d, concat_e;
    
    assign not_a = ~a;
    assign not_b = ~b;
    assign not_c = ~c;
    assign not_d = ~d;
    assign not_e = ~e;
    
    assign concat_a = {5{not_a}};
    assign concat_b = {5{not_b}};
    assign concat_c = {5{not_c}};
    assign concat_d = {5{not_d}};
    assign concat_e = {5{not_e}};
    
    assign out = concat_a ^ concat_b ^ concat_c ^ concat_d ^ concat_e;
    
endmodule
