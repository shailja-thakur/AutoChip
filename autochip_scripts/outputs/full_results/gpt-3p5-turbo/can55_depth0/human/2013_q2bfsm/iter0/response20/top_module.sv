module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);
	
	reg [1:0] state, next_state;
	
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= 2'b00; // Beginning state - State A
		end else begin
			state <= next_state;
		end
	end
	
	// Output f control
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			f <= 1'b0;
		end else begin
			case (state)
				2'b00: f <= 1'b1; // After next clock edge, set output f to 1 for one clock cycle
				default: f <= 1'b0;
			endcase
		end
	end
	
	// Output g control
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			g <= 1'b0;
		end else begin
			case (state)
				2'b01: begin
					        if (x == 1 && #(1) x == 0 && #(1) x == 1) begin // Monitor x input
						        g <= 1'b1; // Set g to 1 on the following clock cycle
					        end else begin
						        g <= 1'b0;
					        end
				        end
				2'b10: begin
					        if (y == 1 && #(1) y == 1) begin // Monitor y input
						        g <= 1'b1; // Set g to 1 permanently
					        end else begin
						        g <= 1'b0; // Set g to 0 permanently
					        end
				        end
				default: g <= 1'b0;
			endcase
		end
	end
	
	// Next state logic
	always @(state, x, y) begin
		case (state)
			2'b00: begin // Beginning state - State A
				        if (!resetn) begin
					        next_state <= 2'b00;
				        end else begin
					        next_state <= 2'b01;
				        end
			        end
			2'b01: begin
				        if (x == 1 && #(1) x == 0 && #(1) x == 1) begin // Monitor x input
					        next_state <= 2'b10;
				        end else begin
					        next_state <= 2'b01;
				        end
			        end
			2'b10: begin
				        if (y == 1 && #(1) y == 1) begin // Monitor y input
					        next_state <= 2'b10;
				        end else begin
					        next_state <= 2'b00;
				        end
			        end
			default: next_state <= 2'b00;
		endcase
	end
	
endmodule
