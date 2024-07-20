module top_module(
    input clk,
    input d,
    output reg q);

    reg q_pos, q_neg;

    // Positive edge logic
    always @(posedge clk) begin
        q_pos <= d;
    end

    // Negative edge logic
    always @(negedge clk) begin
        q_neg <= d;
    end

    // Combine the results from both edges
    always @(*) begin
        if (clk)
            q = q_pos;
        else
            q = q_neg;
    end

endmodule
