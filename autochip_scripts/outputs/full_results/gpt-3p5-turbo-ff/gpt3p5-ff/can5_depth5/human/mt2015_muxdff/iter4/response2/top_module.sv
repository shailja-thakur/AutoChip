module flipflop(
    input clk,
    input D,
    output reg Q
);

always @(posedge clk) begin
    Q <= D;
end

endmodule
module mux_2to1(
    input I0,
    input I1,
    input S,
    output reg O
);

always @(*) begin
    if (S == 0) begin
        O <= I0;
    end else begin
        O <= I1;
    end
end

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg [2:0] Q
);

wire [2:0] q0, q1, q2;
wire [2:0] d0, d1, d2;
wire [1:0] s0, s1, s2;

flipflop ff0(.clk(clk), .D(d0[0]), .Q(q0[0]));
flipflop ff1(.clk(clk), .D(d1[0]), .Q(q1[0]));
flipflop ff2(.clk(clk), .D(d2[0]), .Q(q2[0]));

mux_2to1 mux0(.I0(q0[0]), .I1(q_in), .S(s0[0]), .O(d0[0]));
mux_2to1 mux1(.I0(q1[0]), .I1(q_in), .S(s1[0]), .O(d1[0]));
mux_2to1 mux2(.I0(q2[0]), .I1(q_in), .S(s2[0]), .O(d2[0]));

assign s0[1] = q1[0] ^ q2[0];
assign s1[1] = q0[0];
assign s2[1] = q2[0];

flipflop ff3(.clk(clk), .D(d0[1]), .Q(q0[1]));
flipflop ff4(.clk(clk), .D(d1[1]), .Q(q1[1]));
flipflop ff5(.clk(clk), .D(d2[1]), .Q(q2[1]));

mux_2to1 mux3(.I0(q0[1]), .I1(q_in), .S(s0[1]), .O(d0[1]));
mux_2to1 mux4(.I0(q1[1]), .I1(q_in), .S(s1[1]), .O(d1[1]));
mux_2to1 mux5(.I0(q2[1]), .I1(q_in), .S(s2[1]), .O(d2[1]));

assign s0[0] = q1[1] ^ q2[1];
assign s1[0] = q0[1];
assign s2[0] = q2[1];

flipflop ff6(.clk(clk), .D(d0[2]), .Q(q0[2]));
flipflop ff7(.clk(clk), .D(d1[2]), .Q(q1[2]));
flipflop ff8(.clk(clk), .D(d2[2]), .Q(q2[2]));

mux_2to1 mux6(.I0(q0[2]), .I1(q_in), .S(s0[2]), .O(d0[2]));
mux_2to1 mux7(.I0(q1[2]), .I1(q_in), .S(s1[2]), .O(d1[2]));
mux_2to1 mux8(.I0(q2[2]), .I1(q_in), .S(s2[2]), .O(d2[2]));

assign s0[2] = q1[2] ^ q2[2];
assign s1[2] = q0[2];
assign s2[2] = q2[2];

always @(posedge clk) begin
    if (L) begin
        Q <= r_in;
    end else begin
        Q <= {q1[2] ^ q2[2], q0[2], q2[2]};
    end
end

endmodule
