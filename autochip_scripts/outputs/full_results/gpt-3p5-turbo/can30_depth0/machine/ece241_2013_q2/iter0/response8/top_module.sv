module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    wire sop1, sop2;
    wire pos0, pos1;
  
    assign sop1 = ~a & ~b & c;
    assign sop2 = c & d;
    assign out_sop = sop1 | sop2;
  
    assign pos0 = c & (~b | d) & (~a | b);
    assign pos1 = c & (~a | d);
  
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;
  
endmodule
