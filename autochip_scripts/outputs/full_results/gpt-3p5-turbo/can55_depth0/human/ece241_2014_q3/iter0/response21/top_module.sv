module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

	// Implementing the K-map using multiplexers
	
	// 2-to-1 Multiplexers
	wire M0, M1, M2, M3, M4, M5, M6, M7;
	
	// 4-to-1 Multiplexer
	wire [3:0] mux_out;
	
	// Output Connections
	assign mux_in[0] = M0;
	assign mux_in[1] = M1;
	assign mux_in[2] = M2;
	assign mux_in[3] = M3;
	
	// Connecting the 2-to-1 Multiplexers
	mux2_1 MUX0 (.a(M2), .b(M3), .s(c), .y(M0));
	mux2_1 MUX1 (.a(M6), .b(M7), .s(c), .y(M1));
	mux2_1 MUX2 (.a(d), .b(M2), .s(c), .y(M2));
	mux2_1 MUX3 (.a(M7), .b(M3), .s(c), .y(M3));
	mux2_1 MUX4 (.a(d), .b(M1), .s(c), .y(M4));
	mux2_1 MUX5 (.a(M6), .b(d), .s(c), .y(M5));
	mux2_1 MUX6 (.a(d), .b(M0), .s(c), .y(M6));
	mux2_1 MUX7 (.a(M5), .b(M4), .s(c), .y(M7));
	
	// Connecting the 4-to-1 Multiplexer
	mux4_1 MUX (.a(M4), .b(M5), .c(M6), .d(M7), .s(d), .y(mux_out));

endmodule
module mux2_1 (
	input a,
	input b,
	input s,
	output y
);
	assign y = (~s & a) | (s & b);
endmodule
module mux4_1 (
	input a,
	input b,
	input c,
	input d,
	input [1:0] s,
	output y
);
	assign y = (s == 2'b00) ? a : (s == 2'b01) ? b : (s == 2'b10) ? c : d;
endmodule
