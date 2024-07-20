module flipflop(
    input clk,
    input D,
    output reg Q
);
    always @(posedge clk)
        Q <= D;
endmodule
module mux_2to1(
    input I0,
    input I1,
    input S,
    output reg Y
);
    always @(*)
        case (S)
            2'b00: Y = I0;
            2'b01: Y = I1;
            2'b10: Y = 1'b0;
            2'b11: Y = 1'b1;
        endcase
endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);
    reg q0, q1, q2;
    wire m0_out, m1_out, m2_out;
    
    flipflop ff0 (.clk(clk), .D(q_in), .Q(q0));
    flipflop ff1 (.clk(clk), .D(q0), .Q(q1));
    flipflop ff2 (.clk(clk), .D(q1), .Q(q2));
    
    mux_2to1 mux0 (.I0(r_in), .I1(q2), .S(L), .Y(m0_out));
    mux_2to1 mux1 (.I0(q2), .I1(q0), .S(L), .Y(m1_out));
    mux_2to1 mux2 (.I0(q0), .I1(q1), .S(L), .Y(m2_out));
    
    always @(posedge clk)
        if (L)
            Q <= r_in;
        else
            Q <= m2_out;
endmodule
