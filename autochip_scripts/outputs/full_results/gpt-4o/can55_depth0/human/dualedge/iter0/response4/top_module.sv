module top_module(
    input clk,
    input d,
    output reg q
);
    // Two separate flip-flops triggered on different edges
    reg q1, q2;

    always @(posedge clk) begin
        q1 <= d;
    end

    always @(negedge clk) begin
        q2 <= d;
    end

    // Combine the outputs of the two flip-flops
    always @(posedge clk or negedge clk) begin
        q <= clk ? q1 : q2;
    end

endmodule
