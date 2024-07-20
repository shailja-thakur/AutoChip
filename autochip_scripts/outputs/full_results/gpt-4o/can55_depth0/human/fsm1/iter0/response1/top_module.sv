module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

// State encoding
typedef enum logic [1:0] {
    STATE_A = 2'b00,
    STATE_B = 2'b01
} state_t;

// State variables
state_t current_state, next_state;

// Output logic based on current state
always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= STATE_B;
    end
    else begin
        current_state <= next_state;
    end
end

// Next state logic
always_comb begin
    case (current_state)
        STATE_A: begin
            if (in)
                next_state = STATE_A;
            else
                next_state = STATE_B;
        end
        STATE_B: begin
            if (in)
                next_state = STATE_B;
            else
                next_state = STATE_A;
        end
        default: next_state = STATE_B;  // Default state
    endcase
end

// Output based on current state
always_comb begin
    case (current_state)
        STATE_A: out = 1'b0;
        STATE_B: out = 1'b1;
        default: out = 1'b1;  // Default output
    endcase
end

endmodule
