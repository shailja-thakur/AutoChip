module flipflop(
    input clk,
    input D,
    input reset,
    output reg Q
);

always @(posedge clk) begin
    if (reset)
        Q <= 1'b0;
    else
        Q <= D;
end

endmodule
module mux_2_1(
    input I0,
    input I1,
    input S,
    output reg OUT
);

always @(*) begin
    case (S)
        1'b0: OUT <= I0;
        1'b1: OUT <= I1;
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
wire L;
wire q;
wire [2:0] q_out;

assign r = r_in;
assign L = L;
assign q = q_in;

flipflop flipflop_inst1(
    .clk(clk),
    .D(q),
    .reset(L),
    .Q(q_out[0])
);

flipflop flipflop_inst2(
    .clk(clk),
    .D(q_out[0]),
    .reset(L),
    .Q(q_out[1])
);

flipflop flipflop_inst3(
    .clk(clk),
    .D(q_out[1]),
    .reset(L),
    .Q(Q)
);

mux_2_1 mux_inst(
    .I0(r),
    .I1(q_out[2]),
    .S(L),
    .OUT(q)
);

endmodule
