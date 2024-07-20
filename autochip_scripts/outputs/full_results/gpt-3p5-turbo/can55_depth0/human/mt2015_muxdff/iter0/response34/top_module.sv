module flipflop(
    input clk,
    input reset,
    input D,
    output reg Q
);

always @(posedge clk or posedge reset)
begin
    if(reset)
        Q <= 0;
    else
        Q <= D;
end

endmodule
module mux_2to1(
    input A,
    input B,
    input Sel,
    output reg Out
);

always @(A, B, Sel)
begin
    if(Sel)
        Out <= B;
    else
        Out <= A;
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

flipflop ff1(clk, L, r[0], q[0]);
flipflop ff2(clk, L, r[1], q[1]);
flipflop ff3(clk, L, r[2], q[2]);

mux_2to1 mux(
    q[0],
    q[1],
    L,
    Q
);

endmodule
