module top_module (
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q
);

	reg [255:0] next_q;

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			q <= next_q;
		end
	end

	always @* begin
		for (int i = 0; i < 256; i = i+1) begin
			int x = i % 16;
			int y = i / 16;

			int neighbors = 0;

			neighbors = neighbors + q[((x+15)%16)*16 + ((y+1)%16)]; // Top-left neighbor
			neighbors = neighbors + q[((x+15)%16)*16 + y]; // Left neighbor
			neighbors = neighbors + q[((x+15)%16)*16 + ((y+15)%16)]; // Bottom-left neighbor
			neighbors = neighbors + q[x*16 + ((y+1)%16)]; // Top neighbor
			neighbors = neighbors + q[x*16 + ((y+15)%16)]; // Bottom neighbor
			neighbors = neighbors + q[((x+1)%16)*16 + ((y+1)%16)]; // Top-right neighbor
			neighbors = neighbors + q[((x+1)%16)*16 + y]; // Right neighbor
			neighbors = neighbors + q[((x+1)%16)*16 + ((y+15)%16)]; // Bottom-right neighbor

			if (neighbors == 2) begin
				next_q[i] = q[i];
			end else if (neighbors == 3) begin
				next_q[i] = 1;
			end else begin
				next_q[i] = 0;
			end
		end
	end

endmodule
