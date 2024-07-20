module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n );
    
    wire intermediate_wire1;
    wire intermediate_wire2;
    
    assign intermediate_wire1 = a & b;
    assign intermediate_wire2 = c & d;
    
    assign out = intermediate_wire1 | intermediate_wire2;
    assign out_n = ~out;
    
endmodule
