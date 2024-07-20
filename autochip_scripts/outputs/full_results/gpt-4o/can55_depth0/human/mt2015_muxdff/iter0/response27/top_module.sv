module mux2to1(
    input d0, d1,
    input sel,
    output y
);
    assign y = sel ? d1 : d0;
endmodule
module dff(
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
    output [2:0] Q
);

    wire [2:0] dff_out;
    wire [2:0] mux_out;

    // Instantiating three D flip-flops
    dff dff0 (.clk(clk), .D(mux_out[0]), .Q(Q[0]));
    dff dff1 (.clk(clk), .D(mux_out[1]), .Q(Q[1]));
    dff dff2 (.clk(clk), .D(mux_out[2]), .Q(Q[2]));

    // Instantiating three 2-1 multiplexers
    mux2to1 mux0 (.d0(Q[1] ^ Q[2]), .d1(r[0]), .sel(L), .y(mux_out[0]));
    mux2to1 mux1 (.d0(Q[0]), .d1(r[1]), .sel(L), .y(mux_out[1]));
    mux2to1 mux2 (.d0(Q[2]), .d1(r[2]), .sel(L), .y(mux_out[2]));

endmodule
