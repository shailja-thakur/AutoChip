module top_module (
	input clk,
	input areset,
	input x,
	output z
);

// Define the states
reg [1:0] state, next_state;

// Define the outputs
reg output_z;

// Define the state transitions
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b00; // Reset to state A
    end else begin
        state <= next_state; // Update the current state
    end
end

// Define the next state logic and output logic
always @(state, x) begin
    case (state)
        2'b00: begin
            if (x) begin
                next_state = 2'b10;  // Transition to state B
                output_z = 1'b1;  // Set output z to 1
            end else begin
                next_state = 2'b00;  // Remain in state A
                output_z = 1'b0;  // Set output z to 0
            end
        end

        2'b10: begin
            if (x) begin
                next_state = 2'b10;  // Remain in state B
                output_z = 1'b0;  // Set output z to 0
            end else begin
                next_state = 2'b10;  // Remain in state B
                output_z = 1'b1;  // Set output z to 1
            end
        end

        default: begin
            next_state = 2'b00;  // Default to state A
            output_z = 1'b0;  // Set output z to 0
        end
    endcase
end

// Assign the output signal
assign z = output_z;

endmodule
