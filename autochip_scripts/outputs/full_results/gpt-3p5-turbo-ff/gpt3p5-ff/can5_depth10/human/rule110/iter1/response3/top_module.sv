module top_module(
	input clk,
  input reset,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	reg [511:0] q_buffer;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q_buffer <= 512'b0;
		end else begin
			if (load) begin
				q_buffer <= data;
			end else begin
				q_buffer[511] <= 1'b0;
				for (int i = 1; i < 511; i = i + 1) begin
					if (q_buffer[i-1] && q_buffer[i] && q_buffer[i+1]) begin
						q_buffer[i] <= 1'b0;
					end else begin
						q_buffer[i] <= 1'b1;
					end
				end
				q_buffer[511] <= (q_buffer[510] && q_buffer[511]) ? 1'b0 : 1'b1;
			end
		end
	end

	always @(posedge clk) begin
		q <= q_buffer;
	end

endmodule
