module flipflop (
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
module mux_2to1 (
    input A,
    input B,
    input SEL,
    output reg Y
);

always @(*) begin
    if (SEL) begin
        Y <= B;
    end else begin
        Y <= A;
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
wire [2:0] mux_out_1;
wire [2:0] mux_out_2;

assign r = r_in;
assign q[0] = q_in;
assign q[1] = mux_out_1[2];
assign q[2] = mux_out_2[2];

flipflop ff1 (
    .clk(clk),
    .D(q_in),
    .reset(1'b0),
    .Q(Q)
);

mux_2to1 mux1 (
    .A(q[1]),
    .B(q[2]),
    .SEL(L),
    .Y(mux_out_1)
);

mux_2to1 mux2 (
    .A(r_in),
    .B(q[0]),
    .SEL(L),
    .Y(mux_out_2)
);

endmodule
