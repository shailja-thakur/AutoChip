module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);
    // Intermediate sop value
    wire sop0, sop1;
    
    // Calculate SOP parts
    assign sop0 = c & d;
    assign sop1 = (~a & ~b & c);
    
    // Generate out_sop as the OR of sop0 and sop1
    assign out_sop = sop0 | sop1;

    // Intermediate pos values
    wire pos0, pos1;

    // Calculate POS parts
    assign pos0 = c & (~b | d) & (~a | b);
    assign pos1 = c & (~b | d) & (~a | d);

    // Generate out_pos based on the equality of pos0 and pos1
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
