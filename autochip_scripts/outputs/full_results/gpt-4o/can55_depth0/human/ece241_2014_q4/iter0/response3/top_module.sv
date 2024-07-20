module top_module (
    input clk,
    input x,
    output z
);

    reg q1, q2, q3;
    wire d1, d2, d3;
    
    // XOR gate with x and current state q1
    assign d1 = x ^ q1;
    // AND gate with x and the NOT of current state q2
    assign d2 = x & ~q2;
    // OR gate with x and the NOT of current state q3
    assign d3 = x | ~q3;

    // D flip-flops
    always @(posedge clk) begin
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end

    // XNOR of the D flip-flops outputs
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
