module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);
	
	reg [1:0] state;
	
	always @(posedge clk or posedge areset) begin
		if (areset) 
			state <= 2'b0;
		else if (state == 2'b00) begin // OFF state
			if (j)
				state <= 2'b01; // Transition to ON state
		end else if (state == 2'b01) begin // ON state
			if (!k)
				state <= 2'b01; // Stay in ON state
			else
				state <= 2'b00; // Transition to OFF state
		end
	end
	
	always @(state) begin
		case(state)
			2'b00: out <= 1'b0; // OFF state
			2'b01: out <= 1'b1; // ON state
		endcase
	end
	
endmodule
