module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    wire pos0, pos1;
    wire pos1_eq_pos0;
    wire [2:0] mismatch;
    
    // SOP expressions
    assign out_sop = (~a & ~b & c) | (c & d);
    
    // POS expressions
    assign pos0 = c & (~b | d);
    assign pos1 = c & (~a | ~d); // Fixed the expression
    
    // Ternary expression to assign out_pos
    assign pos1_eq_pos0 = (pos0 === pos1);
    assign mismatch = (pos1_eq_pos0 === 1) ? 3'b000 : 3'b111;
    assign out_pos = mismatch[2];
    
endmodule
