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
        next_state = current_state;
        if (train_valid) begin
            if (train_taken && current_state < STATE_3) begin
                next_state = current_state + 1;
            end else if (!train_taken && current_state > STATE_0) begin
                next_state = current_state - 1;
            end
        end
    end

    // State update logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_1;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    assign state = current_state;

endmodule
