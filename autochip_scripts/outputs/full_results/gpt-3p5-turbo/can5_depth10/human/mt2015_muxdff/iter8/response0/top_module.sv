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
    mux_2to1 mux1 (.I0(q[0]), .I1(m_out[0]), .S(~L), .Y(m_out[1]));
    mux_2to1 mux2 (.I0(q[1]), .I1(m_out[1]), .S(~L), .Y(m_out[2]));
    
    always @(posedge clk)
        if (L)
            Q <= r_in;
        else
            Q <= m_out[2];
endmodule
