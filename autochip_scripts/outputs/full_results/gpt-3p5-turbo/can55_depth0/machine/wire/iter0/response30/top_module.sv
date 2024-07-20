module top_module(
	input wire clk,
	input wire rst,
	output wire data_out,
	output wire valid_out);

	reg [1:0] state;
	reg [7:0] counter;
	reg [7:0] data;

	// Outputs
	assign data_out = data;
	assign valid_out = (state == 3'b010);

	// State machine
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			state <= 3'b000; // Idle state
			counter <= 8'b00000000;
			data <= 8'b00000000;
		end else begin
			case (state)
				3'b000: begin // Idle state
					counter <= 8'b00000000;
					data <= 8'b00000000;
					
					if (in) begin
						state <= 3'b001; // Wait state
					end
				end
				3'b001: begin // Wait state
					counter <= counter + 1;
					data <= 8'b00000000;
					
					if (counter == 8'b11111111) begin
						state <= 3'b010; // Process state
					end
				end
				3'b010: begin // Process state
					data <= in;
					state <= 3'b011; // Done state
				end
				3'b011: begin // Done state
					data <= in;
					
					state <= 3'b000; // Idle state
				end
				default: begin
					state <= 3'b000; // Idle state
				end
			endcase
		end
	end

endmodule
