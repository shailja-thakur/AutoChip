module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n );
    
    wire and1_out, and2_out;
    
    andgate and1 (.a(a), .b(b), .z(and1_out));
    andgate and2 (.a(c), .b(d), .z(and2_out));
    
    orgate or1 (.a(and1_out), .b(and2_out), .z(out));
    
    notgate not1 (.a(out), .z(out_n));
    
endmodule
