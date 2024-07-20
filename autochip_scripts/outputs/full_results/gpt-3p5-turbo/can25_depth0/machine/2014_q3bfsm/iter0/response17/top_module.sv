module top_module(
	input clk,
	input reset,
	input x,
	output reg z
);
	reg [2:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000; // initialize state to A
		end else begin
			case (state)
				3'b000: // A state
					if (x) begin
						state <= 3'b001; // transition to B
					end else begin
						state <= 3'b000; // remain in A
					end
				
				3'b001: // B state
					if (x) begin
						state <= 3'b100; // transition to E
					end else begin
						state <= 3'b001; // remain in B
					end
				
				3'b010: // C state
					if (x) begin
						state <= 3'b001; // transition to B
					end else begin
						state <= 3'b010; // remain in C
					end
				
				3'b011: // D state
					if (x) begin
						state <= 3'b010; // transition to C
					end else begin
						state <= 3'b001; // remain in B
					end
				
				3'b100: // E state
					if (x) begin
						state <= 3'b100; // remain in E
					end else begin
						state <= 3'b011; // transition to D
					end
				
				default: state <= 3'b000; // in case of unknown state, reset to A
			endcase
		end
	end
	
	always @* begin
		if (state == 3'b100 || state == 3'b101) begin // D or E state
			z = 1'b1; // output is high
		end else begin
			z = 1'b0; // output is low
		end
	end
	
endmodule
