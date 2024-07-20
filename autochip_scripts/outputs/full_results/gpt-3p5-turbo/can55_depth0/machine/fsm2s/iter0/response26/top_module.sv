module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg [1:0] state; // Two-state register to store the current state

// State transitions and output assignment
always @(posedge clk or negedge reset) begin
    if (reset == 0) begin
        state <= 2'b00; // Reset state to A
        out <= 0; // Set output to 0 when in state A
    end
    else begin
        case (state)
            2'b00: begin // When state is A
                if (j == 1)
                    state <= 2'b01; // Transition to state B if j is high
                else
                    state <= 2'b00; // Remain in state A if j is low
                out <= 0; // Set output to 0 when in state A
            end
            2'b01: begin // When state is B
                if (k == 1)
                    state <= 2'b00; // Transition to state A if k is high
                else
                    state <= 2'b01; // Remain in state B if k is low
                out <= 1; // Set output to 1 when in state B
            end
        endcase
    end
end

endmodule
