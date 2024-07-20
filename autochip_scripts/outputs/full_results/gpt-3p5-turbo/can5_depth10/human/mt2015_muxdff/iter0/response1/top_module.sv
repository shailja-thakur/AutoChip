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
    output reg Out
);

always @(S)
    if (S)
        Out <= D1;
    else
        Out <= D0;

endmodule
module top_module (
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

reg [2:0] q;
wire [2:0] r;
wire L;

flipflop ff1 (.clk(clk), .D(q_in), .Q(q[0]));
flipflop ff2 (.clk(clk), .D(q[1]));
flipflop ff3 (.clk(clk), .D(q[2]));

mux_2to1 mux (.S(L), .D0(r_in), .D1(q[0]), .Out(r));

always @(posedge clk) begin
    if (L)
        Q <= r_in;
    else
        Q <= q[2];

    q[2:0] <= r;
end

endmodule
