module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	reg [255:0] next_q;

	always @(posedge clk) begin
		if (load) begin
			q <= data; // Load initial state
		end else begin
			for (int i = 0; i < 256; i = i + 1) begin
				int neighbors = 0;
				neighbors = neighbors + q[((i+16)&255)];
				neighbors = neighbors + q[((i+15)&255)];
				neighbors = neighbors + q[((i+1)&255)];
				neighbors = neighbors + q[((i-1)&255)];
				neighbors = neighbors + q[((i-16)&255)];
				neighbors = neighbors + q[((i-15)&255)];
				neighbors = neighbors + q[((i+17)&255)];
				neighbors = neighbors + q[((i-17)&255)];

				if (q[i] == 1) begin // Cell is alive
					if (neighbors < 2) begin
						next_q[i] = 0; // Cell becomes dead
					end else if (neighbors == 2 || neighbors == 3) begin
						next_q[i] = 1; // Cell remains alive
					end else if (neighbors >= 4) begin
						next_q[i] = 0; // Cell becomes dead
					end
				end else begin // Cell is dead
					if (neighbors == 3) begin
						next_q[i] = 1; // Cell becomes alive
					end else begin
						next_q[i] = 0; // Cell remains dead
					end
				end
			end
			q <= next_q; // Update current state
		end
	end

endmodule
