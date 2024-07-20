module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // State definition for the two-bit counter
    typedef enum logic [1:0] {
        STRONG_NOT_TAKEN = 2'b00,    // 0
        WEAK_NOT_TAKEN   = 2'b01,    // 1
        WEAK_TAKEN       = 2'b10,    // 2
        STRONG_TAKEN     = 2'b11     // 3
    } counter_state_t;

    counter_state_t state_reg, state_next;

    // Asynchronous reset to weakly not-taken
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state_reg <= WEAK_NOT_TAKEN;
        end else begin
            state_reg <= state_next;
        end
    end

    // Next state logic
    always_comb begin
        state_next = state_reg;
        if (train_valid) begin
            if (train_taken) begin
                if (state_reg != STRONG_TAKEN) begin
                    state_next = state_reg + 1;
                end
            end else begin
                if (state_reg != STRONG_NOT_TAKEN) begin
                    state_next = state_reg - 1;
                end
            end
        end
    end

    // Output assignment
    assign state = state_reg;

endmodule
