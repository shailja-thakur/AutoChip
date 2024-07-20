module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg [1:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b01;
		end else begin
			case(state)
				2'b00: begin // State B
					if(in) begin
						state <= 2'b01; // Transition from B to B
					end else begin
						state <= 2'b00; // Transition from B to A
					end
				end
				2'b01: begin // State A
					if(in) begin
						state <= 2'b01; // Transition from A to A
					end else begin
						state <= 2'b00; // Transition from A to B
					end
				end
				default: begin
					state <= 2'b01;
				end
			endcase
		end
	end

	assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
