module top_module (
    input clk,
    input x,
    output z
);

    wire q1, q2, q3;
    wire d1, d2, d3;
    wire q1_bar, q2_bar, q3_bar;
    
    // D flip-flop 1
    assign d1 = x ^ q1;
    always @(posedge clk) begin
        q1 <= d1;
    end
    
    // D flip-flop 2
    assign q1_bar = ~q1;
    assign d2 = x & q1_bar;
    always @(posedge clk) begin
        q2 <= d2;
    end
    
    // D flip-flop 3
    assign d3 = x | q1_bar;
    always @(posedge clk) begin
        q3 <= d3;
    end
    
    // Compute output z
    assign q2_bar = ~q2;
    assign q3_bar = ~q3;
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
