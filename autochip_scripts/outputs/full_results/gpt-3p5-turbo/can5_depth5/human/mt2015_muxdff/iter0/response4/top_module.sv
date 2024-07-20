module flipflop(
    input clk,
    input D,
    output reg Q
);

always @(posedge clk) begin
    Q <= D;
end

endmodule
module mux2to1(
    input S,
    input A,
    input B,
    output reg Y
);

always @* begin
    if (S == 1'b0) begin
        Y = A;
    end else begin
        Y = B;
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

reg [2:0] r;
reg [2:0] q;
wire [2:0] q_reg;

always @(posedge clk) begin
    if (L) begin
        q <= r;
    end else begin
        q <= {q[1] ^ q[2], q[0], q[2]};
    end
end

assign q_reg = q;

flipflop flipflop1 (.clk(clk), .D(q_in), .Q(q_reg[0]));
flipflop flipflop2 (.clk(clk), .D(r_in), .Q(r));
mux2to1 mux1 (.S(L), .A(q_in), .B(r_in), .Y(Q));

endmodule
