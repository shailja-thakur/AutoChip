module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);
	
	reg [2:0] Y, next_Y;    // Define present state and next state
	assign Y0 = Y[0];       // Output Y[0]
	
	always @(posedge clk) begin
		Y <= next_Y;    // Update present state with next state at positive edge of clock
	end
	
	always @(*) begin
		case (y)           // Case statement for present state
			3'b000: begin
				if (x) begin
					next_Y = 3'b001; // Next state Y[2:0] x=1
					z = 1;          // Output z
				end else begin
					next_Y = 3'b000; // Next state Y[2:0] x=0
					z = 0;          // Output z
				end
			end
			
			3'b001: begin
				if (x) begin
					next_Y = 3'b100; // Next state Y[2:0] x=1
					z = 0;          // Output z
				end else begin
					next_Y = 3'b001; // Next state Y[2:0] x=0
					z = 0;          // Output z
				end
			end
			
			3'b010: begin
				if (x) begin
					next_Y = 3'b001; // Next state Y[2:0] x=1
					z = 0;          // Output z
				end else begin
					next_Y = 3'b010; // Next state Y[2:0] x=0
					z = 0;          // Output z
				end
			end
			
			3'b011: begin
				if (x) begin
					next_Y = 3'b010; // Next state Y[2:0] x=1
					z = 1;          // Output z
				end else begin
					next_Y = 3'b001; // Next state Y[2:0] x=0
					z = 1;          // Output z
				end
			end
			
			3'b100: begin
				if (x) begin
					next_Y = 3'b100; // Next state Y[2:0] x=1
					z = 1;          // Output z
				end else begin
					next_Y = 3'b011; // Next state Y[2:0] x=0
					z = 1;          // Output z
				end
			end
		endcase
	end
	
endmodule
