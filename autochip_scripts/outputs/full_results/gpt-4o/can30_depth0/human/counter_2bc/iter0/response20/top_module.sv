module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // State encoding
    typedef enum logic [1:0] {
        WEAKLY_NOT_TAKEN = 2'b01,
        WEAKLY_TAKEN     = 2'b10,
        STRONGLY_TAKEN   = 2'b11,
        STRONGLY_NOT_TAKEN = 2'b00
    } state_t;

    state_t current_state, next_state;

    // Output assignment
    assign state = current_state;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= WEAKLY_NOT_TAKEN;
        else
            current_state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        if (train_valid) begin
            if (train_taken) begin
                // Increment the counter
                if (current_state != STRONGLY_TAKEN)
                    next_state = current_state + 1;
            end else begin
                // Decrement the counter
                if (current_state != STRONGLY_NOT_TAKEN)
                    next_state = current_state - 1;
            end
        end
    end

endmodule
