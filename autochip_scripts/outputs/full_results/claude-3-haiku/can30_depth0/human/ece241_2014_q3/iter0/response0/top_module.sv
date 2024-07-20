module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire c_bar, d_bar;
wire [1:0] mux1_out, mux2_out;

// Implement the Karnaugh map using multiplexers
not(c_bar, c);
not(d_bar, d);

// Implement the first row of the Karnaugh map
mux2to1 mux1 (
    .a(1'b0),
    .b(1'b1),
    .s(d),
    .out(mux1_out[0])
);

mux2to1 mux2 (
    .a(mux1_out[0]),
    .b(1'b0),
    .s(c),
    .out(mux1_out[1])
);

// Implement the second row of the Karnaugh map
mux2to1 mux3 (
    .a(1'b1),
    .b(1'b0),
    .s(d),
    .out(mux2_out[0])
);

mux2to1 mux4 (
    .a(mux2_out[0]),
    .b(1'b0),
    .s(c),
    .out(mux2_out[1])
);

// Connect the outputs of the two rows to the 4-to-1 multiplexer
assign mux_in = {mux2_out[1], mux1_out[1], 2'b00};

endmodule
module mux2to1 (
    input a,
    input b,
    input s,
    output out
);

assign out = s ? b : a;

endmodule
