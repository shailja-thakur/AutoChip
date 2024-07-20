module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	reg [2:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000;  // Initializing state to A
		end else begin
			case (state)
				3'b000: begin
					if (w) state <= 3'b001;  // Transition from A to B
					else state <= 3'b000;  // Stay at A
				end
				
				3'b001: begin
					if (w) state <= 3'b010;  // Transition from B to C
					else state <= 3'b100;  // Transition from B to D
				end
				
				3'b010: begin
					if (w) state <= 3'b110;  // Transition from C to E
					else state <= 3'b100;  // Transition from C to D
				end
				
				3'b011: begin
					state <= 3'b000;  // Transition from D to A
				end
				
				3'b100: begin
					if (w) state <= 3'b101;  // Transition from D to F
					else state <= 3'b000;  // Transition from D to A
				end
				
				3'b101: begin
					state <= 3'b010;  // Transition from E to E
				end
				
				3'b110: begin
					if (w) state <= 3'b101;  // Transition from F to C
					else state <= 3'b010;  // Transition from F to E
				end
			endcase
		end
	end
	
	assign z = (state == 3'b110) || (state == 3'b101);  // Set z to 1 if state is E or F

endmodule
