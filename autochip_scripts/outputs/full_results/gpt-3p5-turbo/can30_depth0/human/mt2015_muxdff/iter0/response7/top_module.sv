module flipflop(
    input clk,
    input L,
    input q_in,
    output reg Q
);

always @(posedge clk)
    if (L)
        Q <= q_in;

endmodule
module mux2to1(
    input [1:0] select,
    input d0,
    input d1,
    output reg q
);

always @*
begin
    case(select)
        2'b00: q = d0;
        2'b01: q = d1;
        default: q = 1'b0;
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

wire [2:0] q_out;
wire [2:0] d0;
wire [2:0] d1;
reg [1:0] select;

flipflop ff1 (
    .clk(clk),
    .L(L),
    .q_in(q_in),
    .Q(q_out[0])
);

flipflop ff2 (
    .clk(clk),
    .L(L),
    .q_in(q_out[0]),
    .Q(q_out[1])
);

flipflop ff3 (
    .clk(clk),
    .L(L),
    .q_in(q_out[1]),
    .Q(q_out[2])
);

mux2to1 mux (
    .select(select),
    .d0(r_in),
    .d1(q_out[2]),
    .q(Q)
);

assign d0 = {q_out[0] ^ q_out[2], q_out[1], q_out[2]};
assign d1 = {q_out[1] ^ q_out[2], q_out[0], q_out[2]};

always @*
begin
    if (L)
        select = 2'b00;
    else
        select = 2'b01;
end

endmodule
