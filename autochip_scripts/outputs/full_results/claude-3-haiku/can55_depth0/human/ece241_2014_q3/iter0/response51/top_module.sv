module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire c_bar, d_bar;
wire mux1_out, mux2_out, mux3_out;

// Inverters for c and d
not(c_bar, c);
not(d_bar, d);

// 2-to-1 multiplexers
mux2 m1 (.a(1'b0), .b(1'b1), .sel(d), .out(mux1_out));
mux2 m2 (.a(1'b0), .b(mux1_out), .sel(c), .out(mux2_out));
mux2 m3 (.a(1'b1), .b(mux2_out), .sel(d_bar), .out(mux3_out));

// 4-to-1 multiplexer inputs
assign mux_in[0] = 1'b1;
assign mux_in[1] = 1'b0;
assign mux_in[2] = mux3_out;
assign mux_in[3] = mux1_out;

endmodule
module mux2 (
    input a,
    input b,
    input sel,
    output out
);

assign out = (sel) ? b : a;

endmodule
