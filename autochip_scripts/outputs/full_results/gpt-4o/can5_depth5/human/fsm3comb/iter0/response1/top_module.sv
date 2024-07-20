module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

    always @(*) begin
        case(state)
            2'b00: begin // State A
                if (in == 1'b0)
                    next_state = 2'b00; // Stay in A
                else
                    next_state = 2'b01; // Transition to B
            end
            2'b01: begin // State B
                if (in == 1'b0)
                    next_state = 2'b10; // Transition to C
                else
                    next_state = 2'b01; // Stay in B
            end
            2'b10: begin // State C
                if (in == 1'b0)
                    next_state = 2'b00; // Transition to A
                else
                    next_state = 2'b11; // Transition to D
            end
            2'b11: begin // State D
                if (in == 1'b0)
                    next_state = 2'b10; // Transition to C
                else
                    next_state = 2'b01; // Transition to B
            end
            default: next_state = 2'b00; // Default to state A for safety
        endcase
    end

    assign out = (state == 2'b11) ? 1'b1 : 1'b0; // Output logic based on state
endmodule
