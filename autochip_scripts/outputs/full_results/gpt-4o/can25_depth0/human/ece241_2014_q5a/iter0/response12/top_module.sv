module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// State encoding
typedef enum logic [1:0] {
    S0 = 2'b00,  // Initial state
    S1 = 2'b01   // Start complementing
} state_t;

state_t current_state, next_state;

// State transition logic
always_ff @(posedge clk or posedge areset) begin
    if (areset)
        current_state <= S0;
    else
        current_state <= next_state;
end

// Next state logic
always_comb begin
    case (current_state)
        S0: next_state = (areset) ? S0 : S1;
        S1: next_state = (areset) ? S0 : S1;
        default: next_state = S0;
    endcase
end

// Output logic
always_ff @(posedge clk or posedge areset) begin
    if (areset)
        z <= 0;
    else if (current_state == S1)
        z <= ~x;
end

endmodule
