module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

    // Inputs to mux_in[0] corresponds to ab = 00
    assign mux_in[0] = (!c & d) | (c & !d) | (c & d); // K-map entries 1001 (rows 11, 10, 01)

    // Inputs to mux_in[1] corresponds to ab = 01
    assign mux_in[1] = 0; // K-map entries are all 0 for this case

    // Inputs to mux_in[2] corresponds to ab = 11
    assign mux_in[2] = (c & d) | (!c & !d); // K-map entries 1011 (rows 11, 10, 01)

    // Inputs to mux_in[3] corresponds to ab = 10
    assign mux_in[3] = (!c & d) | (c & d) | (c & !d); // K-map entries 1101 (rows 11, 10, 00)

endmodule
