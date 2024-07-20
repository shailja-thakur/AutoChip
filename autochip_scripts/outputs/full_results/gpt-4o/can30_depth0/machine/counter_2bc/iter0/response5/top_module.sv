module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

// Define state encoding
typedef enum logic [1:0] {
    S0 = 2'b00,
    S1 = 2'b01,
    S2 = 2'b10,
    S3 = 2'b11
} state_t;

state_t curr_state, next_state;

// State sequential logic
always_ff @(posedge clk or posedge areset) begin
    if (areset)
        curr_state <= S1;
    else
        curr_state <= next_state;
end

// State transition logic
always_comb begin
    next_state = curr_state; // Default: stay in current state
    if (train_valid) begin
        if (train_taken) begin
            if (curr_state < S3)
                next_state = curr_state + 1;
        end else begin
            if (curr_state > S0)
                next_state = curr_state - 1;
        end
    end
end

// Output logic
assign state = curr_state;

endmodule
