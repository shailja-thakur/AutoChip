module flipflop (
    input clk,
    input reset,
    input D,
    output reg Q
);
    
always @(posedge clk) begin
    if (reset)
        Q <= 0;
    else
        Q <= D;
end

endmodule
module mux_2to1 (
    input S,
    input [1:0] D,
    output reg Y
);

always @(*) begin
    if (S == 0)
        Y <= D[0];
    else
        Y <= D[1];
end

endmodule
module top_module (
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

flipflop ff1 (.clk(clk), .reset(L), .D(r[0]), .Q(q[0]));
flipflop ff2 (.clk(clk), .reset(L), .D(q[2]), .Q(q[1]));

mux_2to1 mux (.S(L), .D({q[1], q[2]}), .Y(Q));

endmodule
