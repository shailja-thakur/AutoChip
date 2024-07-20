module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

    // State transition logic
    always @(*) begin
        case(state)
            4'b0001: // State A
                if (in == 1'b0)
                    next_state = 4'b0001; // Stay in A
                else
                    next_state = 4'b0010; // Transition to B
            4'b0010: // State B
                if (in == 1'b0)
                    next_state = 4'b0100; // Transition to C
                else
                    next_state = 4'b0010; // Stay in B
            4'b0100: // State C
                if (in == 1'b0)
                    next_state = 4'b0001; // Transition to A
                else
                    next_state = 4'b1000; // Transition to D
            4'b1000: // State D
                if (in == 1'b0)
                    next_state = 4'b0100; // Transition to C
                else
                    next_state = 4'b0010; // Transition to B
            default:
                next_state = 4'b0001; // Default to state A
        endcase
    end

    // Output logic
    assign out = (state == 4'b1000) ? 1'b1 : 1'b0; // Output is high only in state D

endmodule
