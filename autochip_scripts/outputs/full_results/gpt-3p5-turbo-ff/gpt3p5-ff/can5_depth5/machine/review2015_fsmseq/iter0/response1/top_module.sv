module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);
	
	reg [1:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b00; // initial state S
		end else begin
			case (state)
				2'b00: begin // S
					if (data)
						state <= 2'b01; // S1
					else
						state <= 2'b00; // S
				end
				2'b01: begin // S1
					if (data)
						state <= 2'b10; // S11
					else
						state <= 2'b00; // S
				end
				2'b10: begin // S11
					if (data)
						state <= 2'b10; // S11
					else
						state <= 2'b11; // S110
				end
				2'b11: begin // S110
					if (data)
						state <= 2'b10; // Done
					else
						state <= 2'b00; // S
				end
			endcase
		end
	end
	
	assign start_shifting = (state == 2'b10); // Output is high if state is Done
	
endmodule
