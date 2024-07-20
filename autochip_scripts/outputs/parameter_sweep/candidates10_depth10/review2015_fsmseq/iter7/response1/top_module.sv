module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting
);

	reg [3:0] state;
	reg [2:0] seq_count;
	// Internal signal to track the start flag
	reg start_flag;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 4'b0000;
			start_flag <= 0;
			seq_count <= 3'b0;
		end else begin
			case (state)
				4'b0000: begin
					if (data) begin
						state <= 4'b0001;
					end else begin
						state <= 4'b0000;
					end
				end
				4'b0001: begin
					if (data) begin
						state <= 4'b0010;
					end else begin
						state <= 4'b0000;
					end
				end
				4'b0010: begin
					if (data) begin
						state <= 4'b0011;
					end else begin
						state <= 4'b0000;
					end
				end
				4'b0011: begin
					if (data) begin
						if (seq_count < 3'b110) begin
							seq_count <= seq_count + 1;
							state <= 4'b0011;
						end else begin
							state <= 4'b0000;
							start_flag <= 1;
						end
					end else begin
						state <= 4'b0000;
						seq_count <= 3'b0;
					end
				end
			endcase
		end
	end

	always @(posedge clk) begin
		if (reset) begin
			start_shifting <= 0;
		end else begin
			start_shifting <= start_flag;
		end
	end

endmodule
