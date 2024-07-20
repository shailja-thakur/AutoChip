module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

// Define state variables
reg [1:0] state;

// Define outputs
assign out = state[1];

// Define state machine logic
always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 2'b0;
	end else begin
		case (state)
			2'b00: begin
				if (j) begin
					state <= 2'b01;
				end else begin
					state <= 2'b00;
				end
			end
			2'b01: begin
				if (k) begin
					state <= 2'b00;
				end else begin
					state <= 2'b01;
				end
			end
		endcase
	end
end

endmodule
