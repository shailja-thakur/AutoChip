module flipflop(
    input clk,
    input reset,
    input d,
    output reg q
);

always @(posedge clk, posedge reset) begin
    if (reset) begin
        q <= 1'b0;
    end else begin
        q <= d;
    end
end

endmodule
module mux21(
    input s,
    input a,
    input b,
    output reg y
);

always @(a, b, s) begin
    if (s) begin
        y <= a;
    end else begin
        y <= b;
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

reg [2:0] r1, r2, r3;
wire q1, q2, q3;

flipflop ff1(
    .clk(clk),
    .reset(1'b0),
    .d(r_in),
    .q(q1)
);

flipflop ff2(
    .clk(clk),
    .reset(1'b0),
    .d(r_in),
    .q(q2)
);

flipflop ff3(
    .clk(clk),
    .reset(1'b0),
    .d(r_in),
    .q(q3)
);

mux21 mux1(
    .s(L),
    .a(r1),
    .b(q1),
    .y(r2)
);

mux21 mux2(
    .s(L),
    .a(r2),
    .b(q2),
    .y(r3)
);

mux21 mux3(
    .s(L),
    .a(r3),
    .b(q3),
    .y(Q)
);

endmodule
