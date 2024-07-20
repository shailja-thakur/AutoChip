module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

    always_comb begin
        case(state)
            2'b00: begin // State A
                if (in)
                    next_state = 2'b01; // Transition to state B if in is high
                else
                    next_state = 2'b00; // Stay in state A if in is low
            end
            2'b01: begin // State B
                if (in)
                    next_state = 2'b01; // Stay in state B if in is high
                else
                    next_state = 2'b10; // Transition to state C if in is low
            end
            2'b10: begin // State C
                if (in)
                    next_state = 2'b11; // Transition to state D if in is high
                else
                    next_state = 2'b00; // Transition to state A if in is low
            end
            2'b11: begin // State D
                if (in)
                    next_state = 2'b01; // Transition to state B if in is high
                else
                    next_state = 2'b10; // Transition to state C if in is low
            end
        endcase
    end

    always @(posedge next_state) begin
        if (state == 2'b11) // State D
            out <= 1'b1; // Set out to high when in state D
        else
            out <= 1'b0; // Set out to low for other states
    end

endmodule
