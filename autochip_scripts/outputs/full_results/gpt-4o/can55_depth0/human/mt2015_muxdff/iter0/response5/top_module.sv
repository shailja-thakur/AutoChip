module mux2(
    input a,
    input b,
    input sel,
    output y
);
    assign y = sel ? b : a;
endmodule
module dff(
    input clk,
    input d,
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
    wire [2:0] q_int;

    mux2 mux0 (.a(q_int[1] ^ q_int[2]), .b(r[0]), .sel(L), .y(d[0]));
    mux2 mux1 (.a(q_int[0]), .b(r[1]), .sel(L), .y(d[1]));
    mux2 mux2 (.a(q_int[2]), .b(r[2]), .sel(L), .y(d[2]));

    dff dff0 (.clk(clk), .d(d[0]), .q(q_int[0]));
    dff dff1 (.clk(clk), .d(d[1]), .q(q_int[1]));
    dff dff2 (.clk(clk), .d(d[2]), .q(q_int[2]));

    assign q = q_int;

endmodule
