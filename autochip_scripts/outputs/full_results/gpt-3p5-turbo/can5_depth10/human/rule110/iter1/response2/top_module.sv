module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	reg [511:0] q_next; // Next state of q
	enum {IDLE, COMPUTE} state;
	reg [2:0] left, center, right; // Variables to store the values of left, center, and right cells

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			if (state == IDLE) begin
				state = COMPUTE;
			end else if (state == COMPUTE) begin
				left = q[511]; // Retrieve left cell value
				center = q[0]; // Retrieve center cell value
				right = q[1]; // Retrieve right cell value

				q_next = {q[510:0], 1'b0}; // Initialize q_next with boundaries set to 0

				if (left & center & right) begin
					q_next[0] = 1'b0;
				end else if (left & center & ~right) begin
					q_next[0] = 1'b1;
				end else if (left & ~center & right) begin
					q_next[0] = 1'b1;
				end else if (left & ~center & ~right) begin
					q_next[0] = 1'b0;
				end else if (~left & center & right) begin
					q_next[0] = 1'b1;
				end else if (~left & center & ~right) begin
					q_next[0] = 1'b1;
				end else if (~left & ~center & right) begin
					q_next[0] = 1'b1;
				end else if (~left & ~center & ~right) begin
					q_next[0] = 1'b0;
				end

				// Update the state of each cell
				for (int i = 1; i < 511; i = i + 1) begin
					left = q[i - 1];
					center = q[i];
					right = q[i + 1];

					if (left & center & right) begin
						q_next[i] = 1'b0;
					end else if (left & center & ~right) begin
						q_next[i] = 1'b1;
					end else if (left & ~center & right) begin
						q_next[i] = 1'b1;
					end else if (left & ~center & ~right) begin
						q_next[i] = 1'b0;
					end else if (~left & center & right) begin
						q_next[i] = 1'b1;
					end else if (~left & center & ~right) begin
						q_next[i] = 1'b1;
					end else if (~left & ~center & right) begin
						q_next[i] = 1'b1;
					end else if (~left & ~center & ~right) begin
						q_next[i] = 1'b0;
					end
				end

				left = q[510]; // Retrieve left cell value
				center = q[511]; // Retrieve center cell value
				right = 1'b0; // Set right boundary cell to 0

				if (left & center & right) begin
					q_next[511] = 1'b0;
				end else if (left & center & ~right) begin
					q_next[511] = 1'b1;
				end else if (left & ~center & right) begin
					q_next[511] = 1'b1;
				end else if (left & ~center & ~right) begin
					q_next[511] = 1'b0;
				end else if (~left & center & right) begin
					q_next[511] = 1'b1;
				end else if (~left & center & ~right) begin
					q_next[511] = 1'b1;
				end else if (~left & ~center & right) begin
					q_next[511] = 1'b1;
				end else if (~left & ~center & ~right) begin
					q_next[511] = 1'b0;
				end

				q <= q_next;
				
				state = IDLE;
			end
		end
	end

endmodule
