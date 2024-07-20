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
        if (S == 0)
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
    reg [2:0] q;
    wire [2:0] m_out;
    
    flipflop ff0 (.clk(clk), .D(q_in), .Q(q[0]));
    flipflop ff1 (.clk(clk), .D(q[0]), .Q(q[1]));
    flipflop ff2 (.clk(clk), .D(q[1]), .Q(q[2]));
    
    mux_2to1 mux0 (.I0(r_in), .I1(q[2]), .S(~L), .Y(m_out[0]));
    mux_2to1 mux1 (.I0(q[1]), .I1(q[0]), .S(~L), .Y(m_out[1]));
    mux_2to1 mux2 (.I0(q[2]), .I1(q[1]), .S(~L), .Y(m_out[2]));
    
    always @(posedge clk)
        if (L)
            Q <= m_out[1];
        else
            Q <= r_in;
endmodule
