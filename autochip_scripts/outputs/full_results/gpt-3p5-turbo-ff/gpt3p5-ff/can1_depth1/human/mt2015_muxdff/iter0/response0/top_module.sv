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
    input r_in,
    output reg Q
);
    wire q0, q1, q2;

    flipflop ff_0 (.clk(clk), .R(r_in), .S(L), .Q(q0));
    flipflop ff_1 (.clk(clk), .R(r_in), .S(L), .Q(q1));
    flipflop ff_2 (.clk(clk), .R(r_in), .S(L), .Q(q2));

    mux_2to1 mux_0 (.I0(q0), .I1(q1), .SEL(L), .O(Q));
    mux_2to1 mux_1 (.I0(q2), .I1(q_in), .SEL(L), .O(Q));

endmodule
