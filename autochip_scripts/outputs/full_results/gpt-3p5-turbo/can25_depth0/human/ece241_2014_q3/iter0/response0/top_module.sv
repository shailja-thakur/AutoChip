module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire [1:0] ab; // multiplexer selector inputs

// Implementing the logic for ab = 00
and gate1 (ab[0], c, d);
not gate2 (ab[1], c);

// Implementing the logic for ab = 01
and gate3 (mux_in[1], d, ab[1]);
and gate4 (mux_in[2], not(ab[0]), d, not(ab[1]));

// Implementing the logic for ab = 11
and gate5 (mux_in[3], c, not(d));
and gate6 (mux_in[0], ab[0], not(ab[1]));

// Implementing the logic for ab = 10
and gate7 (mux_in[0], c, d);
and gate8 (mux_in[2], not(c), d);
and gate9 (mux_in[3], c, d);

// Connecting the inputs to the 4-to-1 multiplexer
assign mux_in[0] = gate1;
assign mux_in[1] = gate2;
assign mux_in[2] = gate3;
assign mux_in[3] = gate4;

endmodule
