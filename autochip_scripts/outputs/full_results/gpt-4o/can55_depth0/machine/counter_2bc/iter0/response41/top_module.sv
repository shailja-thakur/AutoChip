module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    typedef enum logic [1:0] {
        STATE_0 = 2'b00,
        STATE_1 = 2'b01,
        STATE_2 = 2'b10,
        STATE_3 = 2'b11
    } state_t;
    
    state_t current_state, next_state;

    // Asynchronous reset logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= STATE_1;
        else
            current_state <= next_state;
    end

    // State transition logic
    always_comb begin
        next_state = current_state; // Default to current state
        if (train_valid) begin
            if (train_taken) begin
                if (current_state < STATE_3)
                    next_state = current_state + 1;
            end else begin
                if (current_state > STATE_0)
                    next_state = current_state - 1;
            end
        end
    end

    // Assign current state to output
    assign state = current_state;

endmodule
