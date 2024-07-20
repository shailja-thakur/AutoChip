module flipflop(
    input clk,
    input D,
    output reg Q
);

always @(posedge clk)
    Q <= D;

endmodule
module mux21(
    input [1:0] S,
    input D0,
    input D1,
    output reg Q
);

always @*
begin
    case(S)
        2'b00: Q = D0;
        2'b01: Q = D1;
    endcase
end

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

wire [2:0] r;
assign r = r_in;

reg [2:0] q;
wire mux_out;

always @(posedge clk)
begin
    if (L)
        q <= r;
    else
        q <= {q[1] ^ q[2], q[0], q[2]};
end

flipflop ff1(
    .clk(clk),
    .D(q[0]),
    .Q(mux_out)
);

flipflop ff2(
    .clk(clk),
    .D(q[1]),
    .Q(mux_out)
);

mux21 mux(
    .S({q[1], q[0]}),
    .D0(mux_out),
    .D1(q_in),
    .Q(Q)
);

endmodule
