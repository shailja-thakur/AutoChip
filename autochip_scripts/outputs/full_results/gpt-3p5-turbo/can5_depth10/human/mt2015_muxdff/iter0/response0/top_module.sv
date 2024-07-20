module flipflop (
    input clk,
    input D,
    output reg Q
);

always @(posedge clk) begin
    Q <= D;
end

endmodule
module mux2to1 (
    input I0,
    input I1,
    input SEL,
    output reg O
);

always @(SEL) begin
    if (SEL)
        O <= I1;
    else
        O <= I0;
end

endmodule
module top_module (
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

wire [2:0] r;
wire [2:0] q;

assign r = r_in;
assign q = q_in;

flipflop ff1 (.clk(clk), .D(q[0]), .Q(q[1]));
flipflop ff2 (.clk(clk), .D(q[1]), .Q(q[2]));
flipflop ff3 (.clk(clk), .D(q[2]), .Q(Q));

mux2to1 mux (.I0(r[0]), .I1(r[1]), .SEL(L), .O(q[0]));

endmodule
