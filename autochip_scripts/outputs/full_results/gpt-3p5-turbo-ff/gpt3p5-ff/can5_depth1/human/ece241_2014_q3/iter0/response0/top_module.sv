module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

// Implementing the Karnaugh map using multiplexers
wire mux_out;

// 4-to-1 MUX
assign mux_in[0] = ((~c) & (~d));
assign mux_in[1] = ((~c) & d);
assign mux_in[2] = (c & d);
assign mux_in[3] = (c & (~d));

// 2-to-1 MUX for mux_in[1]
wire mux1_out;
assign mux1_out = (mux_in[2] & (~d)) | (mux_in[0] & d);
assign mux_in[1] = (_a_ & mux_in[1]) | (_b_ & mux1_out);

// 2-to-1 MUX for mux_in[3]
wire mux2_out;
assign mux2_out = (mux_in[0] & (~d)) | (mux_in[2] & d);
assign mux_in[3] = (_a_ & mux_in[3]) | (_b_ & mux2_out);

endmodule
