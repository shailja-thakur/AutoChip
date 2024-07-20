module flipflop(
    input clk,
    input D,
    input reset,
    output reg Q
);

always @(posedge clk) begin
    if (reset) begin
        Q <= 1'b0;
    end else begin
        Q <= D;
    end
end

endmodule
module mux_2to1(
    input S,
    input I0,
    input I1,
    output reg O
);

always @(*) begin
    if (S) begin
        O = I1;
    end else begin
        O = I0;
    end
end

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

// Create individual flipflops and multiplexers for each instantiation
reg [2:0] q1;
reg [2:0] q2;
reg [2:0] q3;
wire mux_out1;
wire mux_out2;
wire mux_out3;

mux_2to1 mux_inst1 (
    .S(L),
    .I0(q_in),
    .I1(r_in),
    .O(mux_out1)
);

mux_2to1 mux_inst2 (
    .S(L),
    .I0(q2[0]),
    .I1(q2[2]),
    .O(mux_out2)
);

mux_2to1 mux_inst3 (
    .S(L),
    .I0(q3[2]),
    .I1(q3[1]),
    .O(mux_out3)
);

flipflop flipflop_inst1 (
    .clk(clk),
    .D(mux_out1),
    .reset(1'b0),
    .Q(q1)
);

flipflop flipflop_inst2 (
    .clk(clk),
    .D(mux_out2),
    .reset(1'b0),
    .Q(q2)
);

flipflop flipflop_inst3 (
    .clk(clk),
    .D(mux_out3),
    .reset(1'b0),
    .Q(q3)
);

always @(posedge clk) begin
    if (L) begin
        Q <= r_in;
    end else begin
        Q <= q1;
    end
end

endmodule
