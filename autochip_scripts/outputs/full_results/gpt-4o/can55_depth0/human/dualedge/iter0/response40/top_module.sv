module top_module(
	input clk,
	input d,
	output reg q);

    reg q_pos, q_neg;

    // Positive edge triggered
    always @(posedge clk) begin
        q_pos <= d;
    end

    // Negative edge triggered
    always @(negedge clk) begin
        q_neg <= d;
    end

    // Combine both rising and falling edges
    always @(*) begin
        q = (clk) ? q_pos : q_neg;
    end

endmodule
