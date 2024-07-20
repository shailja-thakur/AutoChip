module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	reg [15:0] q_next;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 16'b0000;
		end else if (ena[1]) begin
			q_next = q + 16'b0001;
		end else if (ena[2]) begin
			q_next = q + 16'b0010;
		end else if (ena[3]) begin
			q_next = q + 16'b0100;
		end
	end

	assign ena = q[4:2];
    always @(posedge clk) begin
        if (reset)
            q <= 16'b0000;
        else
            q <= q_next;
    end

endmodule
