module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    logic [1:0] next_state;

    // State transition logic
    always_comb begin
        case (state)
            2'b00:    // State 0
                if (train_valid && train_taken)
                    next_state = 2'b01;
                else
                    next_state = state;

            2'b01:    // State 1
                if (train_valid && train_taken)
                    next_state = 2'b10;
                else if (train_valid && !train_taken)
                    next_state = 2'b00;
                else
                    next_state = state;

            2'b10:    // State 2
                if (train_valid && train_taken)
                    next_state = 2'b11;
                else if (train_valid && !train_taken)
                    next_state = 2'b01;
                else
                    next_state = state;

            2'b11:    // State 3
                if (train_valid && !train_taken)
                    next_state = 2'b10;
                else
                    next_state = state;

            default:
                next_state = 2'b01; // Default state to 1
        endcase
    end

    // State register
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b01; // Reset to state 1
        else
            state <= next_state;
    end

endmodule
