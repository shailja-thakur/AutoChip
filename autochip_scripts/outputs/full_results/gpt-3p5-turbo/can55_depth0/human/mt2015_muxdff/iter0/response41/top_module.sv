module flipflop(
    input clk,
    input reset,
    input D,
    output reg Q
);

always @(posedge clk or posedge reset)
begin
    if (reset)
        Q <= 0;
    else
        Q <= D;
end

endmodule
module mux21(
    input [1:0] sel,
    input D0,
    input D1,
    output reg Y
);

always @(*)
begin
    case(sel)
        2'b00: Y = D0;
        2'b01: Y = D1;
        default: Y = 0;
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
wire [2:0] q;

assign r = r_in;
assign Q = q[2];

flipflop flipflop_inst1 (
    .clk(clk),
    .reset(L),
    .D(r[0]),
    .Q(q[0])
);

flipflop flipflop_inst2 (
    .clk(clk),
    .reset(L),
    .D(r[1]),
    .Q(q[1])
);

flipflop flipflop_inst3 (
    .clk(clk),
    .reset(L),
    .D(r[2]),
    .Q(q[2])
);

mux21 mux21_inst (
    .sel(q_in),
    .D0(q[1]),
    .D1(q[2]),
    .Y(Q)
);

endmodule
