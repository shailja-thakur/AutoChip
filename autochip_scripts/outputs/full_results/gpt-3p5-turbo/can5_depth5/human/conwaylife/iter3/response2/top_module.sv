module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q
);
	parameter ROWS = 16;
	parameter COLS = 16;
	reg [255:0] next_q;
	reg [255:0] next_row [0:15];
	reg [255:0] count;
	
	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end 
		else begin
			// Calculate the next state
			
			for (int i = 0; i < ROWS; i = i + 1) begin
				for (int j = 0; j < COLS; j = j + 1) begin
					count = 0;
					
					if (q[16*i + j] == 1) begin
						count = count + 1;
					end
					if (q[16*((i+15)%16) + ((j+15)%16)] == 1) begin
						count = count + 1;
					end
					if (q[16*((i+15)%16) + j] == 1) begin
						count = count + 1;
					end
					if (q[16*((i+15)%16) + ((j+1)%16)] == 1) begin
						count = count + 1;
					end
					if (q[16*i + ((j+1)%16)] == 1) begin
						count = count + 1;
					end
					if (q[16*((i+1)%16) + ((j+15)%16)] == 1) begin
						count = count + 1;
					end
					if (q[16*((i+1)%16) + j] == 1) begin
						count = count + 1;
					end
					if (q[16*((i+1)%16) + ((j+1)%16)] == 1) begin
						count = count + 1;
					end
					
					if (count == 2) begin
						next_row[i][j] = q[16*i + j];
					end 
					else if (count == 3) begin
						next_row[i][j] = 1;
					end 
					else begin
						next_row[i][j] = 0;
					end
				end
			end
			
			// Update the current state
			for (int i = 0; i < ROWS; i = i + 1) begin
				next_q[16*i +: 16] = next_row[i];
			end
			
			q <= next_q;
		end
	end
	
endmodule
