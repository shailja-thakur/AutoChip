module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			reg [255:0] q_temp;
			q_temp = q;
			
			for (integer i = 0; i < 256; i = i + 1) begin
				integer sum = 0;
				
				// Check neighbors
				if (i % 16 != 0) begin
					sum = sum + q_temp[i - 1]; // Left
				end else begin
					sum = sum + q_temp[i + 15]; // Wrap around to right
				end
				
				if ((i + 1) % 16 != 0) begin
					sum = sum + q_temp[i + 1]; // Right
				end else begin
					sum = sum + q_temp[i - 15]; // Wrap around to left
				end
				
				sum = sum + q_temp[i - 16]; // Top
				sum = sum + q_temp[i + 16]; // Bottom
				
				if (i >= 16) begin
					if (i % 16 != 0) begin
						sum = sum + q_temp[i - 17]; // Top-left
					end else begin
						sum = sum + q_temp[i - 1]; // Wrap around to top-right
					end
					
					if ((i + 1) % 16 != 0) begin
						sum = sum + q_temp[i - 15]; // Top-right
					end else begin
						sum = sum + q_temp[i - 31]; // Wrap around to top-left
					end
				end
				
				if (i < 240) begin
					if (i % 16 != 0) begin
						sum = sum + q_temp[i + 15]; // Bottom-left
					end else begin
						sum = sum + q_temp[i + 31]; // Wrap around to bottom-right
					end
					
					if ((i + 1) % 16 != 0) begin
						sum = sum + q_temp[i + 17]; // Bottom-right
					end else begin
						sum = sum + q_temp[i + 1]; // Wrap around to bottom-left
					end
				end
				
				// Update cell state
				case(sum)
					2: q[i] <= q_temp[i];
					3: q[i] <= 1;
					default: q[i] <= 0;
				endcase
			end
		end
	end

endmodule
