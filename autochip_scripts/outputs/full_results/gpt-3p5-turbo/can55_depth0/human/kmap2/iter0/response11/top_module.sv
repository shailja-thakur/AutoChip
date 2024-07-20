module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

// Define intermediate signals
wire signal_1, signal_2, signal_3;

// Implement the Karnaugh map
assign signal_1 = a & b & ~c & d | a & b & c & ~d | ~a & b & c & d | a & ~b & c & d | a & b & c & d;
assign signal_2 = a & ~b & c & ~d | a & b & ~c & ~d | ~a & ~b & c & d | ~a & b & ~c & ~d;
assign signal_3 = a & b & ~c & ~d | ~a & ~b & ~c & d | ~a & b & ~c & d | ~a & b & c & ~d | ~a & ~b & c & ~d;

// Output
assign out = signal_1 | signal_2 | signal_3;

endmodule
