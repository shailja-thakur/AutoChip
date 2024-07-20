module flipflop(
    input clk,
    input R,
    input S,
    output reg Q
);
    always @(posedge clk) begin
        if (R && S)
            Q <= Q;
        else if (R)
            Q <= 0;
        else if (S)
            Q <= 1;
    end
endmodule
module mux_2to1(
    input I0,
    input I1,
    input SEL,
    output reg O
);
    always @(*) begin
        if (SEL)
            O <= I1;
        else
            O <= I0;
    end
endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input [2:0] r_in,
    output reg [2:0] Q
);
    wire [2:0] q0, q1, q2;

    flipflop ff_0 (.clk(clk), .R(r_in[0]), .S(L), .Q(q0[0]));
    flipflop ff_1 (.clk(clk), .R(r_in[1]), .S(L), .Q(q1[0]));
    flipflop ff_2 (.clk(clk), .R(r_in[2]), .S(L), .Q(q2[0]));

    mux_2to1 mux_0 (.I0(q0[0]), .I1(q1[0]), .SEL(L), .O(Q[0]));
    mux_2to1 mux_1 (.I0(q2[0]), .I1(q_in[0]), .SEL(L), .O(Q[0]));

endmodule
