module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	reg [255:0] q_next;

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			q <= q_next;
		end
	end

	always @* begin
		for (int i = 0; i < 16; i = i + 1) begin
			for (int j = 0; j < 16; j = j + 1) begin
				int count_neighbors = 0;
				if (q[i*16+((j+1)%16)]) count_neighbors = count_neighbors + 1;
				if (q[i*16+((j-1+16)%16)]) count_neighbors = count_neighbors + 1;
				if (q[((i+1)%16)*16+j]) count_neighbors = count_neighbors + 1;
				if (q[((i-1+16)%16)*16+j]) count_neighbors = count_neighbors + 1;
				if (q[((i+1)%16)*16+((j+1)%16)]) count_neighbors = count_neighbors + 1;
				if (q[((i+1)%16)*16+((j-1+16)%16)]) count_neighbors = count_neighbors + 1;
				if (q[((i-1+16)%16)*16+((j+1)%16)]) count_neighbors = count_neighbors + 1;
				if (q[((i-1+16)%16)*16+((j-1+16)%16)]) count_neighbors = count_neighbors + 1;

				if (count_neighbors <= 1) begin
					q_next[i*16+j] = 0;
				end else if (count_neighbors == 2) begin
					q_next[i*16+j] = q[i*16+j];
				end else if (count_neighbors == 3) begin
					q_next[i*16+j] = 1;
				end else begin
					q_next[i*16+j] = 0;
				end
			end
		end
	end

endmodule
