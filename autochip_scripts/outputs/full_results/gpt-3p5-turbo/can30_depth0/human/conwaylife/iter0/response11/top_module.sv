module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);
	
	reg [255:0] next_q;

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			// Update the game state according to the rules
			for (integer i = 0; i < 256; i = i + 1) begin
				reg count = 0;
				
				// Count the number of neighbors
				if (i % 16 != 0) begin
					if (q[i - 1] == 1) begin
						count = count + 1;
					end
				end
				if (i % 16 != 15) begin
					if (q[i + 1] == 1) begin
						count = count + 1;
					end
				end
				if (i >= 16) begin
					if (q[i - 16] == 1) begin
						count = count + 1;
					end
				end
				if (i < 240) begin
					if (q[i + 16] == 1) begin
						count = count + 1;
					end
				end
				if ((i % 16 != 0) && (i >= 16)) begin
					if (q[i - 17] == 1) begin
						count = count + 1;
					end
				end
				if ((i % 16 != 15) && (i >= 16)) begin
					if (q[i - 15] == 1) begin
						count = count + 1;
					end
				end
				if ((i % 16 != 0) && (i < 240)) begin
					if (q[i + 15] == 1) begin
						count = count + 1;
					end
				end
				if ((i % 16 != 15) && (i < 240)) begin
					if (q[i + 17] == 1) begin
						count = count + 1;
					end
				end
				
				// Update the cell state based on the count
				if ((count >= 4) || (count <= 1)) begin
					next_q[i] = 0;
				end else if (count == 3) begin
					next_q[i] = 1;
				end else begin
					next_q[i] = q[i];
				end
			end
			
			// Update the current game state
			q <= next_q;
		end
	end
endmodule
