module top_module (
    input clk,
    input reset,
    input x,
    output z
);
	// Internal state representation
	reg [2:0] state;
	
	// Assign initial state A upon reset
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b001;
		else
			state <= state;
	end
	
	// Output logic
	always @* begin
		case (state)
			3'b000: z = 1'b1; // State D
			3'b001: z = 1'b1; // State E
			default: z = 1'b0;
		endcase
	end
	
	// State transition logic
	always @(posedge clk) begin
		case({state, x})
			2'b00: state <= 3'b000; // State A, x low
			2'b01: state <= 3'b001; // State B, x high
			2'b10: state <= 3'b010; // State C, x low
			2'b11: begin // Either D or E, x high
				if (state == 3'b011) // State D
					state <= 3'b010;
				else // State E
					state <= 3'b001;
			end
		endcase
	end
endmodule
