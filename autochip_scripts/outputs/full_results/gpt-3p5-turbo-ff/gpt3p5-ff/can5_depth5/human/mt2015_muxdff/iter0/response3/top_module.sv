module flipflop(
    input clk,
    input D,
    output reg Q
);
    always @(posedge clk) begin
        Q <= D;
    end
endmodule
module mux_2to1(
    input A,
    input B,
    input S,
    output reg Y
);
    always @* begin
        if (S) begin
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
    output reg Q1,
    output reg Q2,
	output reg Q3
);
	wire [2:0] q;
    flipflop ff1(clk, q_in, Q1);
    flipflop ff2(clk, q[1], Q2);
    flipflop ff3(clk, q[2], Q3);
    mux_2to1 m1(q[1], r_in, L, q[0]);
    mux_2to1 m2(q[2], q[0], L, q[1]);
    mux_2to1 m3(q[1], q[2], L, q[2]);
endmodule
