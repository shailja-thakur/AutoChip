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

    // State transition logic
    always_comb begin
        next_state = current_state; // Default to remain in current state
        if (train_valid) begin
            if (train_taken) begin
                if (current_state < STATE_3) begin
                    next_state = current_state + 2'b01;
                end
            end else begin
                if (current_state > STATE_0) begin
                    next_state = current_state - 2'b01;
                end
            end
        end
    end

    // State flip-flops with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_1;
        end else begin
            current_state <= next_state;
        end
    end

    // Output assignment
    assign state = current_state;

endmodule
