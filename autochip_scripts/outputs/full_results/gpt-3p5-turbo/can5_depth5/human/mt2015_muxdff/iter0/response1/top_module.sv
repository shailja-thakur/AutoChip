module flipflop(
    input clk,
    input D,
    output reg Q
);
always @(posedge clk)
    Q <= D;
endmodule
module mux_2to1(
    input S,
    input D0,
    input D1,
    output reg Q
);
always @(S)
    if (S == 1'b0)
        Q <= D0;
    else
        Q <= D1;
endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);
wire mux_out;
wire flipflop_out;

mux_2to1 mux1(.S(L), .D0(q_in), .D1(r_in), .Q(mux_out));
flipflop ff1(.clk(clk), .D(mux_out), .Q(flipflop_out));

always @(posedge clk)
    Q <= flipflop_out;

endmodule
