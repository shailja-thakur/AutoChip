module top_module(
    input clk,
    input d,
    output reg q
);

    reg d_ff1, d_ff2;

    // First flip-flop triggered on positive edge
    always @(posedge clk) begin
        d_ff1 <= d;
    end

    // Second flip-flop triggered on negative edge
    always @(negedge clk) begin
        d_ff2 <= d;
    end

    // Combine the output of the two flip-flops to create the desired behavior
    always @(*) begin
        q <= d_ff1 | d_ff2;
    end

endmodule
