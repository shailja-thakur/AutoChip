module flipflop (
    input clk,
    input D,
    output reg Q
);
    always @(posedge clk)
        Q <= D;
endmodule
module mux_2to1(
    input S,
    input I0,
    input I1,
    output reg Y
);
    always @(*)
        if (S == 1'b0)
            Y = I0;
        else
            Y = I1;
endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);
    wire Q1, Q2, Q3;
    wire M1, M2, M3;
    
    flipflop FF1 (.clk(clk), .D(q_in), .Q(Q1));
    flipflop FF2 (.clk(clk), .D(Q1), .Q(Q2));
    flipflop FF3 (.clk(clk), .D(Q2), .Q(Q3));
    
    mux_2to1 MUX1 (.S(L), .I0(r_in), .I1(q_in), .Y(M1));
    mux_2to1 MUX2 (.S(L), .I0(Q1), .I1(Q2), .Y(M2));
    mux_2to1 MUX3 (.S(L), .I0(Q2), .I1(Q3), .Y(M3));
    
    assign Q = (L) ? r_in : M3;
endmodule
