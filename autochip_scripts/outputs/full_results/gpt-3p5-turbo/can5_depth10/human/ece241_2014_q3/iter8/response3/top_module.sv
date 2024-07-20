module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire a, b;

assign a = c & (~d);
assign b = ~c & d;

// Implementing the 4-to-1 mux using 2-to-1 muxes
wire [1:0] m0, m1, m2, m3;
assign m0 = (a & b) ? 1'b0 : (c & d) ? 1'b1 : 1'b0;
assign m1 = (~a & b) ? 1'b0 : (~c & ~d) ? 1'b0 : 1'b1;
assign m2 = (a & ~b) ? 1'b1 : (~c & d) ? 1'b0 : 1'b0;
assign m3 = (~a & ~b) ? 1'b0 : (c & ~d) ? 1'b0 : 1'b1;

// Implementing the 4-to-1 mux using 2-to-1 muxes
wire [1:0] n0, n1;
assign n0 = (m0 & m1) ? 1'b0 : (m2 & m3) ? 1'b1 : 1'b0;
assign n1 = (m0 | m2) ? 1'b0 : (m1 | m3) ? 1'b1 : 1'b0;

assign mux_in[0] = n0[0];
assign mux_in[1] = n1[0];
assign mux_in[2] = n1[1];
assign mux_in[3] = n0[1];

endmodule
