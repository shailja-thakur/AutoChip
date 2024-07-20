module mux2to1 (
    input a,
    input b,
    input sel,
    output out
);
    assign out = sel ? b : a;
endmodule
module d_flipflop (
    input clk,
    input D,
    output reg Q
);
    always @(posedge clk) begin
        Q <= D;
    end
endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r,
    input [2:0] q_in,
    output [2:0] Q
);
    wire mux_out0, mux_out1, mux_out2;
    wire dff_out0, dff_out1, dff_out2;

    // Instantiating mux and flip-flop for q[0]
    mux2to1 mux0 (.a(q_in[1] ^ q_in[2]), .b(r[0]), .sel(L), .out(mux_out0));
    d_flipflop dff0 (.clk(clk), .D(mux_out0), .Q(dff_out0));

    // Instantiating mux and flip-flop for q[1]
    mux2to1 mux1 (.a(q_in[0]), .b(r[1]), .sel(L), .out(mux_out1));
    d_flipflop dff1 (.clk(clk), .D(mux_out1), .Q(dff_out1));

    // Instantiating mux and flip-flop for q[2]
    mux2to1 mux2 (.a(q_in[2]), .b(r[2]), .sel(L), .out(mux_out2));
    d_flipflop dff2 (.clk(clk), .D(mux_out2), .Q(dff_out2));

    assign Q = {dff_out2, dff_out1, dff_out0};
endmodule
