module flipflop(
    input clk,
    input reset,
    input d,
    output reg q
);

always @(posedge clk) begin
    if (reset)
        q <= 0;
    else
        q <= d;
end

endmodule
module mux_2_1(
    input a,
    input b,
    input sel,
    output reg o
);

always @(*) begin
    if (sel)
        o = b;
    else
        o = a;
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
wire [2:0] q_out;

wire d;
wire mux_sel;

flipflop flipflop_inst1(
    .clk(clk),
    .reset(0),
    .d(d),
    .q(q_out[0])
);

flipflop flipflop_inst2(
    .clk(clk),
    .reset(0),
    .d(d),
    .q(q_out[1])
);

flipflop flipflop_inst3(
    .clk(clk),
    .reset(0),
    .d(d),
    .q(q_out[2])
);

mux_2_1 mux_inst(
    .a(r_in),
    .b(q_out[1] ^ q_out[2]),
    .sel(mux_sel),
    .o(d)
);

assign r = {r_in[0], r_in[1], r_in[2]};
assign mux_sel = q_out[2] & L;

always @(posedge clk) begin
    if (L) begin
        Q <= r_in;
    end else begin
        Q <= q_out;
    end
end

endmodule
