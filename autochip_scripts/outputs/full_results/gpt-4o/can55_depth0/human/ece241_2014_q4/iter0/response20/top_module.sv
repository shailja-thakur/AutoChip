module top_module (
    input clk,
    input x,
    output reg z
);
    // Intermediate signals to hold the D flip-flop outputs
    reg q1, q2, q3;
    wire d1, d2, d3;
    wire q2_bar, q3_bar;
    wire xnor_out;
    
    // Compute complemented outputs
    assign q2_bar = ~q2;
    assign q3_bar = ~q3;
    
    // XOR, AND, OR gates
    assign d1 = x ^ q1;
    assign d2 = x & q2_bar;
    assign d3 = x | q3_bar;

    // D flip-flops
    always @(posedge clk) begin
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end

    // 3-input XNOR gate
    assign xnor_out = ~(q1 ^ q2 ^ q3);

    // Output Z
    always @(posedge clk) begin
        z <= xnor_out;
    end

endmodule
