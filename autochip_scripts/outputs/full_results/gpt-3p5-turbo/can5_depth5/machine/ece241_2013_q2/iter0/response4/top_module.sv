module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    wire pos0, pos1;  // Define wires for intermediate signals

    // Generate out_sop using SOP expression
    assign out_sop = (c & d) | ((!a & !b & c));  // SOP expression

    // Generate out_pos using POS expression
    assign pos0 = c & (!b | d) | (!a & b);  // First intermediate signal
    assign pos1 = c & (!a | d);  // Second intermediate signal

    assign out_pos = (pos0 === pos1) ? pos0 : 1'bx;  // Ternary expression for out_pos

endmodule
