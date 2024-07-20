module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b00; // A state
	end else begin
		case(state)
			2'b00: begin // A state
				if (j) begin
					next_state <= 2'b01; // B state
				end else begin
					next_state <= 2'b00; // A state
				end
			end
			2'b01: begin // B state
				if (k) begin
					next_state <= 2'b00; // A state
				end else begin
					next_state <= 2'b01; // B state
				end
			end
			default: begin
				next_state <= 2'b00; // A state
			end
		endcase
	end
end

always @(posedge clk) begin
	state <= next_state;
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
