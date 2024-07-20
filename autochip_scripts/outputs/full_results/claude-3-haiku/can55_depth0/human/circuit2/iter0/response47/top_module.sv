module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

wire q_tmp;

// Implement the combinational logic based on the given simulation waveforms
assign q_tmp = (~a & ~b & ~c & ~d) |
               (~a & ~b & c & ~d) |
               (~a & b & ~c & d) |
               (~a & b & c & ~d) |
               (a & ~b & ~c & d) |
               (a & ~b & c & ~d) |
               (a & b & ~c & ~d) |
               (a & b & c & d);

// Connect the temporary output to the final output
assign q = q_tmp;

endmodule
