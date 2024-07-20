module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

// State definition
typedef enum logic [1:0] {
	SEARCH,  // Search for start of message
	DONE     // Message received
} state_t;

// Registers
reg [1:0] state_reg;
reg [2:0] count_reg;

// Combinational logic
always_comb begin
	done = (state_reg == DONE);
end

// Synchronous logic
always @(posedge clk) begin
	if (reset) begin
		state_reg <= SEARCH;
		count_reg <= 0;
	end else begin
		case (state_reg)
			SEARCH:
				if (in[3] == 1'b1) begin
					state_reg <= DONE;
					count_reg <= 1;
				end
			DONE:
				count_reg <= count_reg + 1;
				if (count_reg == 3) begin
					state_reg <= SEARCH;
					count_reg <= 0;
				end
		endcase
	end
end

endmodule
