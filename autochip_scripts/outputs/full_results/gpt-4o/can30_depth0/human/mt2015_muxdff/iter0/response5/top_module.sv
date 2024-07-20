module mux2x1(
    input a,
    input b,
    input sel,
    output y
);
    assign y = sel ? b : a;
endmodule
module dff(
    input d,
    input clk,
    output reg q
);
    always @(posedge clk) begin
        q <= d;
    end
endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);
    wire [2:0] d;
    wire [2:0] mux_out;

    // Instantiate 3 muxes
    mux2x1 mux0 (.a(q[2]), .b(r[0]), .sel(L), .y(mux_out[0]));
    mux2x1 mux1 (.a(q[0]), .b(r[1]), .sel(L), .y(mux_out[1]));
    mux2x1 mux2 (.a(q[1]), .b(r[2]), .sel(L), .y(mux_out[2]));

    // XOR combination for D inputs to DFFs
    assign d[0] = mux_out[1] ^ mux_out[2];
    assign d[1] = mux_out[0];
    assign d[2] = mux_out[2];

    // Instantiate 3 flip-flops
    dff dff0(.d(d[0]), .clk(clk), .q(q[0]));
    dff dff1(.d(d[1]), .clk(clk), .q(q[1]));
    dff dff2(.d(d[2]), .clk(clk), .q(q[2]));
endmodule
