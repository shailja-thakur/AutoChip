module top_module(
    input clk,
    input d,
    output reg q);
    
    reg q_pos, q_neg;

    // Trigger on positive edge of the clock
    always @(posedge clk) begin
        q_pos <= d;
    end

    // Trigger on negative edge of the clock
    always @(negedge clk) begin
        q_neg <= d;
    end

    // Combining the results of both edges
    always @(posedge clk or negedge clk) begin
        q <= clk ? q_pos : q_neg;
    end

endmodule
