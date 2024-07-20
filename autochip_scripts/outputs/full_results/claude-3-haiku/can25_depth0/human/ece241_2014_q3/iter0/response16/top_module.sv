module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire a, b;
    wire mux1_out, mux2_out, mux3_out;

    // Implement the Karnaugh map using multiplexers
    assign a = c;
    assign b = d;

    assign mux1_out = (~a & ~b & 1) | (a & ~b & 0) | (~a & b & 0) | (a & b & 1);
    assign mux2_out = (~a & ~b & 0) | (a & ~b & 1) | (~a & b & 0) | (a & b & 0);
    assign mux3_out = (~a & ~b & 1) | (a & ~b & 0) | (~a & b & 1) | (a & b & 1);

    assign mux_in = {mux3_out, mux2_out, mux1_out, 1'b1};

endmodule
