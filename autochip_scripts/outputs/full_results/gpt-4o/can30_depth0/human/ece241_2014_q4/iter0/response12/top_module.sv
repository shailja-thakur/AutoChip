module top_module (
    input clk,
    input x,
    output z
);

    // Define internal signals
    reg q1, q2, q3;
    wire d1, d2, d3;

    // Logic for the first flip-flop
    assign d1 = x ^ q1;

    // Logic for the second flip-flop
    assign d2 = x & ~q2;

    // Logic for the third flip-flop
    assign d3 = x | ~q3;

    // Flip-flop instantiation and update logic
    always @(posedge clk) begin
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end

    // XNOR of the outputs of the flip-flops
    assign z = ~(q1 ^ q2 ^ q3);
    
endmodule
