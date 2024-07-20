module top_module (
    input clk,
    input x,
    output z
);
    // Intermediate wire declarations
    wire q1, q2, q3;
    wire d1, d2, d3;
    wire q1_n, q2_n, q3_n;
    
    // D Flip-Flop instantiations
    // Flip-flop 1
    always @(posedge clk or negedge x) begin
        q1 <= d1;
    end
    
    // Flip-flop 2
    always @(posedge clk or negedge x) begin
        q2 <= d2;
    end
    
    // Flip-flop 3
    always @(posedge clk or negedge x) begin
        q3 <= d3;
    end
    
    // Flip-flop outputs
    assign q1_n = ~q1;
    assign q2_n = ~q2;
    assign q3_n = ~q3;
    
    // Construct the next state input for each flip-flop
    assign d1 = x ^ q1;
    assign d2 = x & q2_n;
    assign d3 = x | q3_n;
    
    // Construct the three-input XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
