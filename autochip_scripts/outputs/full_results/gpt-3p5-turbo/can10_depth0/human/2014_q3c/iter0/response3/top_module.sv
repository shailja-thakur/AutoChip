module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);
	// Define the state transition table
	reg [2:0] next_state;
	
	always @(posedge clk) begin
		case({y, x})
			
			// Present state: 000
			3'b000_0:
				begin
					Y0 <= 1'b0;
					next_state <= 3'b000;
				end
			
			3'b000_1:
				begin
					Y0 <= 1'b0;
					next_state <= 3'b001;
				end
			
			// Present state: 001
			3'b001_0:
				begin
					Y0 <= 1'b0;
					next_state <= 3'b001;
				end
			
			3'b001_1:
				begin
					Y0 <= 1'b0;
					next_state <= 3'b100;
				end
			
			// Present state: 010
			3'b010_0:
				begin
					Y0 <= 1'b0;
					next_state <= 3'b010;
				end
			
			3'b010_1:
				begin
					Y0 <= 1'b0;
					next_state <= 3'b001;
				end
			
			// Present state: 011
			3'b011_0:
				begin
					Y0 <= 1'b1;
					next_state <= 3'b001;
				end
			
			3'b011_1:
				begin
					Y0 <= 1'b0;
					next_state <= 3'b010;
				end
			
			// Present state: 100
			3'b100_0:
				begin
					Y0 <= 1'b1;
					next_state <= 3'b011;
				end
			
			3'b100_1:
				begin
					Y0 <= 1'b0;
					next_state <= 3'b100;
				end
			
			default:
				begin
					Y0 <= 1'b0;
					next_state <= 3'b000;
				end
			
		endcase
	end
	
	always @(posedge clk) begin
		case(next_state)
			
			// Present state: 000
			3'b000:
				z <= 1'b0;
			
			// Present state: 001
			3'b001:
				z <= 1'b0;
			
			// Present state: 010
			3'b010:
				z <= 1'b0;
			
			// Present state: 011
			3'b011:
				z <= 1'b1;
			
			// Present state: 100
			3'b100:
				z <= 1'b1;
			
			default:
				z <= 1'b0;
			
		endcase
	end
	
endmodule
