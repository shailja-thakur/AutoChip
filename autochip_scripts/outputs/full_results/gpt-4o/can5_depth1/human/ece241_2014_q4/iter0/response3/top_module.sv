module top_module (
    input clk,
    input x,
    output z
);

    // Declare internal wires for D flip-flops
    wire d1, d2, d3;
    wire q1, q2, q3;
    wire q1_n, q2_n, q3_n;
    
    // Create D flip-flops
    dff dff1 (.clk(clk), .d(d1), .q(q1));
    dff dff2 (.clk(clk), .d(d2), .q(q2));
    dff dff3 (.clk(clk), .d(d3), .q(q3));
    
    // Invert the outputs of D flip-flops for AND and OR gates
    not (q1_n, q1);
    not (q2_n, q2);
    not (q3_n, q3);

    // Logic for d1, d2, d3
    assign d1 = x ^ q1;
    assign d2 = x & q2_n;
    assign d3 = x | q3_n;

    // 3-input XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
module dff (
    input clk,
    input d,
    output reg q
);

    always @(posedge clk) begin
        q <= d;
    end

endmodule
