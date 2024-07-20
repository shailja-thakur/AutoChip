module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);
	
	// state parameters
	parameter OFF = 0;
	parameter ON = 1;
	
	// state register
	reg [1:0] state;
	
	// output register
	reg out_reg;
	
	// always block for synchronous reset and state transition
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= OFF;
		end else begin
			case(state)
				OFF: begin
					if (j) begin
						state <= ON;
					end
				end
				
				ON: begin
					if (k) begin
						state <= OFF;
					end
				end
			endcase
		end
	end
	
	// always block for output assignment
	always @(state) begin
		case(state)
			OFF: begin
				out_reg <= 0;
			end
			
			ON: begin
				out_reg <= 1;
			end
		endcase
	end
	
	// assign output
	assign out = out_reg;
	
endmodule
