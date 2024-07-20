module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	integer i, j, k, l;
	reg [3:0] neighbor_count;

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			reg [255:0] next_q;
			for (i = 0; i < 16; i = i + 1) begin
				for (j = 0; j < 16; j = j + 1) begin
					neighbor_count = 0;

					// Count the number of alive neighbours
					for (k = -1; k <= 1; k = k + 1) begin
						for (l = -1; l <= 1; l = l + 1) begin
							if (!(k == 0 && l == 0)) begin
								neighbor_count = neighbor_count + q[(((i + k) + 16) % 16) * 16 + ((j + l + 16) % 16)];
							end
						end
					end

					// Apply the rules of the game
					case (neighbor_count)
						// 0-1 neighbour: Cell becomes 0
						4'd0, 4'd1: next_q[i * 16 + j] = 1'b0;
						// 2 neighbours: Cell state does not change
						4'd2: next_q[i * 16 + j] = q[i * 16 + j];
						// 3 neighbours: Cell becomes 1
						4'd3: next_q[i * 16 + j] = 1'b1;
						// 4+ neighbours: Cell becomes 0
						default: next_q[i * 16 + j] = 1'b0;
					endcase
				end
			end
			q <= next_q;
		end
	end

endmodule
