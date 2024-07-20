module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

wire ab_nor, ab_and, bc_nor, bc_and, cd_nor, cd_and;

// Implement the logic from the waveform
nor (ab_nor, a, b);
and (ab_and, a, b);
nor (bc_nor, b, c);
and (bc_and, b, c);
nor (cd_nor, c, d);
and (cd_and, c, d);

// Implement the output logic
or (q, ab_nor, bc_and, cd_nor);

endmodule
