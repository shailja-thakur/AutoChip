module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);


reg [1:0] state;
wire w_count;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b00;
	end else begin
		case(state)
			2'b00: begin // State A
				if (s) begin
					state <= 2'b01; // Move to State B
				end else begin
					state <= 2'b00; // Remain in State A
				end
			end
			
			2'b01: begin // State B
				if (w_count) begin
					state <= 2'b10; // Move to State C
				end else begin
					state <= 2'b01; // Remain in State B
				end
			end
			
			2'b10: begin // State C
				state <= 2'b11; // Move to State D
			end
			
			2'b11: begin // State D
				if (w_count) begin
					z <= 1; // Set output z to 1
					state <= 2'b01; // Move back to State B
				end else begin
					z <= 0; // Set output z to 0
					state <= 2'b10; // Stay in State C
				end
			end
		endcase
	end
end

assign w_count = (w == 1) ? (w_count + 1'b1) : (w_count - 1'b1);

endmodule
