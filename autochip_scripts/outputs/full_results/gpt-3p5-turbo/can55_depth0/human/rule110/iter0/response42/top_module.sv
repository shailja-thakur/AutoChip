module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	always @(posedge clk) begin
		if(load) begin
			q <= data;
		end else begin
			for(int i = 0; i < 512; i = i + 1) begin
				if(i == 0) begin
					if(q[1:0] == 2'b01 || q[1:0] == 2'b00) begin
						q[i] <= 1'b1;
					end else begin
						q[i] <= 1'b0;
					end
				end else if(i == 511) begin
					if(q[510:511] == 2'b10 || q[510:511] == 2'b01) begin
						q[i] <= 1'b1;
					end else begin
						q[i] <= 1'b0;
					end
				end else begin
					if(q[i-1:i+1] == 3'b111) begin
						q[i] <= 1'b0;
					end else if(q[i-1:i+1] == 3'b110) begin
						q[i] <= 1'b1;
					end else if(q[i-1:i+1] == 3'b101) begin
						q[i] <= 1'b1;
					end else if(q[i-1:i+1] == 3'b100) begin
						q[i] <= 1'b0;
					end else if(q[i-1:i+1] == 3'b011) begin
						q[i] <= 1'b1;
					end else if(q[i-1:i+1] == 3'b010) begin
						q[i] <= 1'b1;
					end else if(q[i-1:i+1] == 3'b001) begin
						q[i] <= 1'b1;
					end else if(q[i-1:i+1] == 3'b000) begin
						q[i] <= 1'b0;
					end
				end
			end
		end
	end

endmodule
