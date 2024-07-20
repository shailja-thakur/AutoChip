module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output reg out
);

always @* begin
    case (state)
        2'b00: begin // State A
            if (in)
                next_state = 2'b01; // Transition to state B
            else
                next_state = 2'b00; // Remain in state A
            out = 1'b0; // Output for state A
        end
        2'b01: begin // State B
            if (in)
                next_state = 2'b01; // Remain in state B
            else
                next_state = 2'b10; // Transition to state C
            out = 1'b0; // Output for state B
        end
        2'b10: begin // State C
            if (in)
                next_state = 2'b11; // Transition to state D
            else
                next_state = 2'b00; // Transition to state A
            out = 1'b0; // Output for state C
        end
        2'b11: begin // State D
            if (in)
                next_state = 2'b01; // Transition to state B
            else
                next_state = 2'b10; // Transition to state C
            out = 1'b1; // Output for state D
        end
        default: begin // Default case to handle unexpected state values
            next_state = 2'b00;
            out = 1'b0;
        end
    endcase
end

endmodule
