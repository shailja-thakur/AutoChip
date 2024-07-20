module top_module (
    input clk,
    input in,
    input areset,
    output out
);
	reg [1:0] state;
	reg out_reg;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b00; // Reset the state to A
		end else begin
			case (state)
				2'b00: begin // State is A
					if (in) begin // Input is 1
						state <= 2'b01; // Next state is B
					end else begin // Input is 0
						state <= 2'b00; // Next state is A
					end
				end
				2'b01: begin // State is B
					if (in) begin // Input is 1
						state <= 2'b01; // Next state is B
					end else begin // Input is 0
						state <= 2'b10; // Next state is C
					end
				end
				2'b10: begin // State is C
					if (in) begin // Input is 1
						state <= 2'b11; // Next state is D
					end else begin // Input is 0
						state <= 2'b00; // Next state is A
					end
				end
				2'b11: begin // State is D
					if (in) begin // Input is 1
						state <= 2'b01; // Next state is B
					end else begin // Input is 0
						state <= 2'b10; // Next state is C
					end
				end
			endcase
		end
	end
	
	always @(state) begin
		if (state == 2'b11) begin // State is D
			out_reg <= 1; // Set output to 1
		end else begin
			out_reg <= 0; // Set output to 0
		end
	end
	
	assign out = out_reg;
	
endmodule
