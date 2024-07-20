module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

    // mux_in[0] corresponds to ab = 00
    assign mux_in[0] = ~c & ~d; // 00: 0, 01: 1, 11: 1, 10: 1 -> ~c & ~d + c & d&#91;not shown computation for all rows&#93;

    // mux_in[1] corresponds to ab = 01
    assign mux_in[1] = 1'b0; // 00: 0, 01: 0, 11: 0, 10: 0 [do not assign 'b as c or d]

    // mux_in[2] corresponds to ab = 11
    assign mux_in[2] = c & d | c & ~d; // 00: 0, 01: 0, 11: 1, 10: 0 -> c & d 

    // mux_in[3] corresponds to ab = 10
    assign mux_in[3] = c; // 00: 1, 01: 0, 11: 1, 10: 1 -> c

endmodule
