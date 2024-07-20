module top_module(
	input clk,
	input d,
	output reg q);
    
    // Internal signals
    reg q_pos;
    reg q_neg;

    // Posedge flip-flop
    always @(posedge clk) begin
        q_pos <= d;
    end

    // Negedge flip-flop
    always @(negedge clk) begin
        q_neg <= d;
    end

    // Combining the results
    always @(posedge clk or negedge clk) begin
        q <= (clk) ? q_pos : q_neg;
    end

endmodule
