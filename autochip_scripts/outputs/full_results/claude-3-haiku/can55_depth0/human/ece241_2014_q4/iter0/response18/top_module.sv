module top_module (
    input clk,
    input x,
    output z
);

wire q1, q2, q3;
wire q1_not, q2_not, q3_not;

// D flip-flops
dff dff1 (
    .clk(clk),
    .d(q1),
    .q(q1),
    .q_not(q1_not)
);

dff dff2 (
    .clk(clk),
    .d(q2),
    .q(q2),
    .q_not(q2_not)
);

dff dff3 (
    .clk(clk),
    .d(q3),
    .q(q3),
    .q_not(q3_not)
);

// Combinational logic
assign q1 = x ^ q1;
assign q2 = x & q2_not;
assign q3 = x | q3_not;

// Output logic
assign z = ~(q1 ^ q2 ^ q3);

endmodule
module dff (
    input clk,
    input d,
    output reg q,
    output reg q_not
);

always @(posedge clk) begin
    q <= d;
    q_not <= ~d;
end

endmodule
