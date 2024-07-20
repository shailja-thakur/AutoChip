module flipflop (
    input clk, 
    input reset,
    input D, 
    output reg Q
);
 
always @(posedge clk or posedge reset) begin
    if (reset)
        Q <= 1'b0;
    else
        Q <= D;
end
 
endmodule
module mux (
    input [1:0] S, 
    input [1:0] D, 
    output reg Y
);
 
always @(*)
    case (S)
        2'b00: Y = D[0];
        2'b01: Y = D[1];
        2'b10: Y = D[2];
        2'b11: Y = D[3];
    endcase
 
endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);
 
wire [2:0] q;
reg [2:0] r;
reg q_out;
reg [4:0] d;
wire [1:0] s;
 
assign s[0] = L;
assign s[1] = q_in[0];
 
mux mux_inst (
    .S(s),
    .D({q_in[1], r_in, r}),
    .Y(d)
);
 
flipflop ff_inst (
    .clk(clk),
    .reset(L),
    .D(d),
    .Q(q_out)
);
 
always @(posedge clk) begin
    r <= r_in;
    Q <= q_out;
    q <= q_in;
end
 
endmodule
