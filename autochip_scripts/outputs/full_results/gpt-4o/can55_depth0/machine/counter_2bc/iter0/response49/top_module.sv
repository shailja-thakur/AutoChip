module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

// State encoding
typedef enum logic [1:0] {
    S0 = 2'b00,
    S1 = 2'b01,
    S2 = 2'b10,
    S3 = 2'b11
} state_t;

state_t current_state, next_state;

// State transition logic
always_ff @(posedge clk or posedge areset) begin
    if (areset)
        current_state <= S1;
    else if (train_valid)
        current_state <= next_state;
end

// Next state logic
always_comb begin
    next_state = current_state;
    if (train_valid) begin
        if (train_taken && current_state < S3)
            next_state = current_state + 1;
        else if (!train_taken && current_state > S0)
            next_state = current_state - 1;
    end
end

// Output state
assign state = current_state;

endmodule
