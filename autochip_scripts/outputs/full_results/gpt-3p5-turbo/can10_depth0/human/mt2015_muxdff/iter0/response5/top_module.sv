module flipflop (
    input clk,
    input reset,
    input D,
    output reg Q
);

always @(posedge clk or posedge reset)
    if (reset)
        Q <= 1'b0;
    else
        Q <= D;
endmodule
module mux2to1 (
    input select,
    input D0,
    input D1,
    output reg Y
);

always @*
    if (select)
        Y <= D1;
    else
        Y <= D0;
endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

reg [2:0] q;
wire [2:0] r;
assign r = r_in;

flipflop ff1 (
    .clk(clk),
    .reset(L),
    .D(r),
    .Q(q[0])
);

flipflop ff2 (
    .clk(clk),
    .reset(L),
    .D(q_in),
    .Q(q[1])
);

 flipflop ff3 (
    .clk(clk),
    .reset(L),
    .D({q[1] ^ q[2], q[0], q[2]}),
    .Q(q[2])
 );

mux2to1 mux (
    .select(L),
    .D0(q[1]),
    .D1(r),
    .Y(Q)
);

endmodule
