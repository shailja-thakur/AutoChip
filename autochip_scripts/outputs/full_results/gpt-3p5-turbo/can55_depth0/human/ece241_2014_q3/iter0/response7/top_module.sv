module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

// Implementing the K-map using one 4-to-1 multiplexer and as few 2-to-1 multiplexers as possible

wire [1:0] ab;
assign ab[0] = c;
assign ab[1] = d;

// Creating the circuit using multiplexers

// 2-to-1 multiplexer for mux_in[0]
wire [3:0] mux0;
assign mux0[0] = 1'b1;
assign mux0[1] = 1'b0;
assign mux0[2] = 1'b0;
assign mux0[3] = 1'b1;
assign mux_in[0] = mux0[ab];

// 2-to-1 multiplexer for mux_in[1]
wire [3:0] mux1;
assign mux1[0] = 1'b0;
assign mux1[1] = 1'b0;
assign mux1[2] = 1'b0;
assign mux1[3] = 1'b0;
assign mux_in[1] = mux1[ab];

// 2-to-1 multiplexer for mux_in[2]
wire [3:0] mux2;
assign mux2[0] = 1'b0;
assign mux2[1] = 1'b0;
assign mux2[2] = 1'b0;
assign mux2[3] = 1'b1;
assign mux_in[2] = mux2[ab];

// 2-to-1 multiplexer for mux_in[3]
wire [3:0] mux3;
assign mux3[0] = 1'b1;
assign mux3[1] = 1'b0;
assign mux3[2] = 1'b0;
assign mux3[3] = 1'b1;
assign mux_in[3] = mux3[ab];

endmodule
