module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // State declarations
    typedef enum logic [1:0] {
        STATE_0 = 2'b00,
        STATE_1 = 2'b01,
        STATE_2 = 2'b10,
        STATE_3 = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_comb begin
        case (current_state)
            STATE_0: if (train_valid & train_taken)
                        next_state = STATE_1;
                     else
                        next_state = STATE_0;

            STATE_1: if (train_valid & train_taken)
                        next_state = STATE_2;
                     else if (train_valid & ~train_taken)
                        next_state = STATE_0;
                     else
                        next_state = STATE_1;

            STATE_2: if (train_valid & train_taken)
                        next_state = STATE_3;
                     else if (train_valid & ~train_taken)
                        next_state = STATE_1;
                     else
                        next_state = STATE_2;

            STATE_3: if (train_valid & ~train_taken)
                        next_state = STATE_2;
                     else
                        next_state = STATE_3;

            default: next_state = STATE_1; // Default state
        endcase
    end

    // State register
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= STATE_1;
        else
            current_state <= next_state;
    end

    // Output logic
    assign state = current_state;

endmodule
