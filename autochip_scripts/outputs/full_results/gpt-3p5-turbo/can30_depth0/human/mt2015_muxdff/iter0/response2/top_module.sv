module flipflop(
    input clk,
    input D,
    input reset,
    output reg Q
);

always @(posedge clk) begin
    if (reset) begin
        Q <= 0;
    end else begin
        Q <= D;
    end
end

endmodule
module mux(
    input sel,
    input a,
    input b,
    output reg y
);

always @(sel, a, b) begin
    if (sel) begin
        y <= b;
    end else begin
        y <= a;
    end
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

flipflop ff1(
    .clk(clk),
    .D(q_in),
    .reset(L),
    .Q(q[0])
);

flipflop ff2(
    .clk(clk),
    .D(q[1] ^ q[2]),
    .reset(L),
    .Q(q[1])
);

flipflop ff3(
    .clk(clk),
    .D(q[0]),
    .reset(L),
    .Q(q[2])
);

mux mux_inst(
    .sel(r[0]),
    .a(q[1]),
    .b(q[2]),
    .y(Q)
);

endmodule
