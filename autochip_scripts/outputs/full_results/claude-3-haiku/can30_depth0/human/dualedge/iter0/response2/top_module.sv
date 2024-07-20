module top_module(
    input clk,
    input d,
    output reg q
);

    // Use a positive edge-triggered flip-flop and a negative edge-triggered flip-flop
    // to achieve the functionality of a dual-edge triggered flip-flop
    reg q_pos, q_neg;

    // Positive edge-triggered flip-flop
    always @(posedge clk) begin
        q_pos <= d;
    end

    // Negative edge-triggered flip-flop
    always @(negedge clk) begin
        q_neg <= d;
    end

    // Combine the outputs of the two flip-flops using a multiplexer
    always @(*) begin
        if (clk)
            q = q_pos;
        else
            q = q_neg;
    end

endmodule
