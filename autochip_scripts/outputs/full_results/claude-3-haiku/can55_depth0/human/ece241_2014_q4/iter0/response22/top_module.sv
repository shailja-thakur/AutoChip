module top_module (
    input clk,
    input x,
    output z
);

// Declare flip-flop outputs
wire q1, q2, q3;
wire q1_bar, q2_bar, q3_bar;

// Instantiate D flip-flops
dff d1 (.clk(clk), .d(x ^ q1), .q(q1), .q_bar(q1_bar));
dff d2 (.clk(clk), .d(x & q2_bar), .q(q2), .q_bar(q2_bar));
dff d3 (.clk(clk), .d(x | q3_bar), .q(q3), .q_bar(q3_bar));

// Compute the XNOR of the three flip-flop outputs
assign z = ~(q1 ^ q2 ^ q3);

// Instantiate the D flip-flop module
module dff (
    input clk,
    input d,
    output reg q,
    output reg q_bar
);

    always @(posedge clk) begin
        q <= d;
        q_bar <= ~d;
    end
endmodule
