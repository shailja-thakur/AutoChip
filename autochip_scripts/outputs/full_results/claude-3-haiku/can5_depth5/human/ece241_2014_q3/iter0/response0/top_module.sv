module top_module(
    input c,
    input d,
    output [3:0] mux_in
);

wire [1:0] mux2_out;
wire mux1_out;

// First 2-to-1 mux, selects between c and d based on c
assign mux1_out = c ? d : 1'b0;

// Second 2-to-1 mux, selects between mux1_out and 1'b1 based on d
assign mux2_out[0] = d ? mux1_out : 1'b1;

// Third 2-to-1 mux, selects between mux1_out and 1'b1 based on c
assign mux2_out[1] = c ? mux1_out : 1'b1;

// 4-to-1 mux, selects between the outputs of the 2-to-1 muxes
assign mux_in = {mux2_out[1], mux2_out[0], 2'b00};

endmodule
