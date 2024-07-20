module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	
	reg [1:0] state;
	
	always @(posedge clk) begin
		if (reset)
			state <= 2'b10; // B
		else begin
			case (state)
				2'b10: begin // B
					if (in)
						state <= 2'b10;
					else
						state <= 2'b01; // A
				end
				2'b01: begin // A
					if (in)
						state <= 2'b01; 
					else
						state <= 2'b10; // B
				end
				default: state <= 2'b10; // B
			endcase
		end
	end
	
	always @(state) begin
		case (state)
			2'b10: out = 1'b1; // B
			2'b01: out = 1'b0; // A
			default: out = 1'b1; // B
		endcase
	end
	
endmodule
