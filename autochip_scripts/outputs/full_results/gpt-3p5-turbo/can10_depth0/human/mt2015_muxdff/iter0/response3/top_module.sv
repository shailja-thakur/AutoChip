module flipflop(
    input clk,
    input D,
    input reset,
    output reg Q
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        Q <= 1'b0;
    end else begin
        Q <= D;
    end
end

endmodule
module mux2to1(
    input S,
    input D0,
    input D1,
    output reg Y
);

always @(S or D0 or D1) begin
    if (S) begin
        Y <= D1;
    end else begin
        Y <= D0;
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

wire [2:0] q_int;
wire [2:0] r_int;

flipflop ff (
    .clk(clk),
    .D(q_in),
    .reset(L),
    .Q(q_int[0])
);

flipflop ff1 (
    .clk(clk),
    .D(q_int[0]),
    .reset(L),
    .Q(q_int[1])
);

flipflop ff2 (
    .clk(clk),
    .D(q_int[1]),
    .reset(L),
    .Q(q_int[2])
);

mux2to1 mux (
    .S(L),
    .D0(r_in),
    .D1(q_int[2]),
    .Y(Q)
);

endmodule
