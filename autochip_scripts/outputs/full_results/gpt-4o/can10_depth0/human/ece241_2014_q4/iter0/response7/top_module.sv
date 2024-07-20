module top_module (
    input clk,
    input x,
    output z
);

    // Internal signals for flip-flop outputs
    reg q1, q2, q3;
    
    // Logic for D inputs to flip-flops
    wire d1 = x ^ q1;
    wire d2 = x & ~q2;
    wire d3 = x | ~q3;
    
    // Instantiate D flip-flops
    always @(posedge clk) begin
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end

    // XNOR gate to combine the outputs of the flip-flops
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
