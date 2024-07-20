module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	reg [2:0] state;
	reg z_signal;

	always @(posedge clk or negedge areset) begin
		if (areset == 0) begin
			state <= 3'b000;
			z_signal <= 1'b0;
		end else begin
			case (state)
				3'b000: begin // State 0
						 if (x) begin
						 	state <= 3'b001; // Transition to State 1
						 end else begin
						 	state <= 3'b000; // Stay in State 0
						 end
						 z_signal <= 1'b0;
				end
				3'b001: begin // State 1
						 if (x) begin
						 	state <= 3'b001; // Stay in State 1
						 end else begin
						 	state <= 3'b010; // Transition to State 2
						 end
						 z_signal <= 1'b0;
				end
				3'b010: begin // State 2
						 if (x) begin
						 	state <= 3'b010; // Stay in State 2
						 end else begin
						 	state <= 3'b010; // Stay in State 2
						 end
						 z_signal <= 1'b1;
				end
			endcase
		end
	end
	
	assign z = z_signal;
endmodule
