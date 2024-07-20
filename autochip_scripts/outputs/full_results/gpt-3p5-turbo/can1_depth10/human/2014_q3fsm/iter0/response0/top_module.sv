module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
	reg [1:0] state, nextState;

	// reset state
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b00;
		end else begin
			state <= nextState;
		end
	end

	// state transition and output logic
	always @(*) begin
		case(state)
			2'b00: begin // State A
				if (s) begin
					nextState = 2'b01; // Move to State B
				end else begin
					nextState = 2'b00; // Stay in State A
				end
				z = 0;
			end
			
			2'b01: begin // State B
				if (w) begin
					nextState = 2'b10;
				end else begin
					nextState = 2'b01;
				end
				z = 0;
			end
			
			default: begin // State C
				if (w == 2'b01) begin
					nextState = 2'b10;
					z = 0;
				end else if (w == 2'b00) begin
					nextState = 2'b01;
					z = 0;
				end else if (w == 2'b10) begin
					nextState = 2'b11;
					z = 0;
				end else if (w == 2'b11) begin
					nextState = 2'b00;
					z = 1;
				end
			end
		endcase
	end
endmodule
