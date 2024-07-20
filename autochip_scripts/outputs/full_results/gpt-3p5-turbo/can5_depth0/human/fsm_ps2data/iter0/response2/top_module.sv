module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [2:0] state;

	// Implement the FSM
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000;
		end else begin
			case (state)
				3'b000: begin // Idle state
					if (in[3]) begin
						state <= 3'b001;
					end
				end
				3'b001: begin // First byte received
					state <= 3'b010;
				end
				3'b010: begin // Second byte received
					state <= 3'b011;
				end
				3'b011: begin // Third byte received
					state <= 3'b100;
				end
				3'b100: begin // Message complete
					state <= 3'b000;
				end
			endcase
		end
	end

	reg [7:0] byte1;
	reg [7:0] byte2;
	reg [7:0] byte3;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			byte1 <= 8'b0;
			byte2 <= 8'b0;
			byte3 <= 8'b0;
		end else begin
			case (state)
				3'b000: begin // Idle state
					byte1 <= 8'b0;
					byte2 <= 8'b0;
					byte3 <= 8'b0;
				end
				3'b001: begin // First byte received
					byte1 <= in;
				end
				3'b010: begin // Second byte received
					byte2 <= in;
				end
				3'b011: begin // Third byte received
					byte3 <= in;
				end
				3'b100: begin // Message complete
					byte1 <= 8'b0;
					byte2 <= 8'b0;
					byte3 <= 8'b0;
				end
			endcase
		end
	end

	assign out_bytes = {byte1, byte2, byte3};
	assign done = (state == 3'b100);

endmodule
