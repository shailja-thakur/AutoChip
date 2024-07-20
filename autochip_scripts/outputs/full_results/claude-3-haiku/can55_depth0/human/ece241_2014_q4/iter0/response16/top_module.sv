module top_module (
    input clk,
    input x,
    output z
);

    wire q1, q2, q3, n1, n2, n3;
    
    // D Flip-Flops
    dff dff1 (.clk(clk), .d(n1), .q(q1), .q_n(n1));
    dff dff2 (.clk(clk), .d(n2), .q(q2), .q_n(n2));
    dff dff3 (.clk(clk), .d(n3), .q(q3), .q_n(n3));
    
    // Gates
    assign n1 = x ^ q1;
    assign n2 = x & ~q2;
    assign n3 = x | q3;
    
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
module dff (
    input clk,
    input d,
    output reg q,
    output reg q_n
);

    always @(posedge clk) begin
        q <= d;
        q_n <= ~d;
    end

endmodule
