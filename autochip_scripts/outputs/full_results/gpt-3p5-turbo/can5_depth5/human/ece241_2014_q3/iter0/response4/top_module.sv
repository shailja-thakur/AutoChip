module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

// Declare internal wire

wire w1, w2, w3, w4, w5, w6, w7, w8;
wire x0, x1, x2, x3;

// Implement Karnaugh map using multiplexers

// mux_in[0] = f(c'd') = Σ(0,2,8,10,11,14)

// mux_in[0] = (cd')' = c + d

assign w1 = c;
assign w2 = d;
assign w3 = c' & d';
assign w4 = c' & d;
assign w5 = c & d' & c' & d;
assign w6 = c' & d' & c' & d;
assign w7 = c' & d;
assign w8 = c & d;

assign x0 = w1 | w2 | w3 | w4 | w5 | w6 | w7 | w8;
assign mux_in[0] = x0;

// mux_in[1] = f(c'd') = Σ(1,2,4,5,6,7,8,9,10,11,12,13)

// mux_in[1] = (cd) + (c'd')

assign w1 = c & d;
assign w2 = c' & d;
assign w3 = c & d';
assign w4 = c' & d';
assign w5 = c & d & c' & d';
assign w6 = c & d & c' & d;
assign w7 = c' & d & c' & d';
assign w8 = c' & d & c' & d;
assign w9 = c & d & c' & d & c & d;
assign w10 = c' & d & c' & d & c' & d';
assign w11 = c & d & c' & d & c' & d';
assign w12 = c & d & c' & d & c & d';
assign w13 = c & d & c' & d & c &d & c' & d;
assign w14 = c' & d & c' & d & c & d' & c & d & d & c;
assign w15 = c & d & c' & d & c & d' & c & d & c & d';

assign x1 = w1 | w2 | w3 | w4 | w5 | w6 | w7 | w8 | w9 | w10 | w11 | w12 | w13 | w14 | w15;
assign mux_in[1] = x1;

// mux_in[2] = f(c'd') = Σ(3,5,6,7,9,10,11,13)

// mux_in[2] = (c'd) + (cd')

assign w1 = c' & d;
assign w2 = c & d;
assign w3 = c' & d';
assign w4 = c & d';
assign w5 = c' & d & c & d' & c' & d';
assign w6 = c' & d & c & d' & c & d;
assign w7 = c' & d & c' & d & c & d';
assign w8 = c & d & c & d' & c & d';
assign w9 = c' & d & c' & d' & c & d';

assign x2 = w1 | w2 | w3 | w4 | w5 | w6 | w7 | w8 | w9;
assign mux_in[2] = x2;

// mux_in[3] = f(c'd') = Σ(11,13,14,15)

// mux_in[3] = c + d' + c' + d

assign w1 = c;
assign w2 = d';
assign w3 = c';
assign w4 = d;

assign x3 = w1 | w2 | w3 | w4;
assign mux_in[3] = x3;

endmodule
