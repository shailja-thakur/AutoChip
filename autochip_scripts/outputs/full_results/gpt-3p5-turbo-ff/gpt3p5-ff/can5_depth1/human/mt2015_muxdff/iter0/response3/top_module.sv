module flipflop (
    input clk,
    input D,
    output reg Q
);

always @(posedge clk) begin
    Q <= D;
end

endmodule
module mux_2to1 (
    input S,
    input D0,
    input D1,
    output reg Q
);

always @(*) begin
    if (S) begin
        Q <= D1;
    end else begin
        Q <= D0;
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
assign q_in = q;

flipflop ff1 (
    .clk(clk),
    .D(r[0]),
    .Q(q[0])
);

flipflop ff2 (
    .clk(clk),
    .D(q[0] ^ q[1]),
    .Q(q[1])
);

flipflop ff3 (
    .clk(clk),
    .D({q[1] ^ q[2], q[0], q[2]}),
    .Q(q[2])
);

mux_2to1 mux (
    .S(L),
    .D0(r[2]),
    .D1(q[2]),
    .Q(Q)
);

endmodule
