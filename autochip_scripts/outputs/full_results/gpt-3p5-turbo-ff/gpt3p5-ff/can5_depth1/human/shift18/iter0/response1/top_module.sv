module top_module(
	input clk,
	input load,
	input ena,
	input [1:0] amount,
	input [63:0] data,
	output reg [63:0] q);
	
	always @(posedge clk) begin
		
		if (load) begin // Load data into shift register
			q <= data;
		end else if (ena) begin // Shift operation
			
			if (amount == 2'b00) begin // Shift left by 1 bit
				q <= {q[62:0], q[63]};
			end else if (amount == 2'b01) begin // Shift left by 8 bits
				q <= {q[55:0], q[63:56]};
			end else if (amount == 2'b10) begin // Shift right by 1 bit
				q <= {q[0], q[63:1]};
			end else if (amount == 2'b11) begin // Shift right by 8 bits
				q <= {q[7:0], q[63:8]};
			end
			
		end
	end
	
endmodule
