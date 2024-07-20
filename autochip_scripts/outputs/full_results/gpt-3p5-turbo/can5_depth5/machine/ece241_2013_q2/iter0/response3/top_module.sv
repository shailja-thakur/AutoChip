module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);
    
    wire sop1;
    wire sop2;
    
    assign sop1 = c & d | ~a & ~b & c;
    assign sop2 = c & (~b | d) & (~a | b);
    
    assign out_sop = sop1;
    assign out_pos = (sop1 == sop2) ? sop1 : 1'bx;
    
endmodule
