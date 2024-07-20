module top_module (
    input clk,
    input x,
    output z
);
    reg q1, q2, q3;

    // Initialize flip-flops to zero
    initial begin
        q1 = 0;
        q2 = 0;
        q3 = 0;
    end

    always @(posedge clk) begin
        // Update the state of each flip-flop with the corresponding logic
        q1 <= x ^ q1;
        q2 <= x & ~q2;
        q3 <= x | ~q3;
    end

    // Create the XNOR output
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
