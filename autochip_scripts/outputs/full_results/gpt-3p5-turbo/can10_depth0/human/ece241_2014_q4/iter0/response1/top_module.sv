module top_module (
    input clk,
    input x,
    output z
);

reg d1, d2, d3;
wire q1, q2, q3;

assign d1 = x ^ q1;
assign d2 = ~(x & q2);
assign d3 = ~(x | q3);

d_flip_flop dff1clk (.CLK(clk), .RESET(1'b0), .D(d1), .Q(q1));
d_flip_flop dff2clk (.CLK(clk), .RESET(1'b0), .D(d2), .Q(q2));
d_flip_flop dff3clk (.CLK(clk), .RESET(1'b0), .D(d3), .Q(q3));

xnor3_gate xnor3 (.A(q1), .B(q2), .C(q3), .Z(z));

endmodule
module d_flip_flop (
    input CLK,
    input RESET,
    input D,
    output reg Q
);
    
always @(posedge CLK or posedge RESET)
    if (RESET == 1'b1)
        Q <= 1'b0;
    else
        Q <= D;
        
endmodule
module xnor3_gate (
    input A,
    input B,
    input C,
    output Z
);

assign Z = ~(A ^ B ^ C);

endmodule
