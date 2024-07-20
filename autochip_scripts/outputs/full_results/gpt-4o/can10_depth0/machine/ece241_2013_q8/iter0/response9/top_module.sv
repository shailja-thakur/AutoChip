module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

// State encoding
typedef enum logic [1:0] {
    S   = 2'b00,
    S1  = 2'b01,
    S10 = 2'b10
} state_t;

// State variables
state_t state, next_state;

// State transitional logic
always @(*) begin
    case (state)
        S: begin
            if (x == 1) next_state = S1;
            else next_state = S;
        end
        S1: begin
            if (x == 1) next_state = S1;
            else next_state = S10;
        end
        S10: begin
            if (x == 1) next_state = S1;
            else next_state = S;
        end
        default: next_state = S; // Default to handle unexpected values
    endcase
end

// State flip-flops and reset logic
always @(posedge clk or negedge aresetn) begin
    if (!aresetn)
        state <= S; // Reset to State 'S'
    else
        state <= next_state; // Update to next state
end

// Output logic
always @(*) begin
    case (state)
        S: z = 0;
        S1: z = 0;
        S10: z = x;
        default: z = 0; // Default to handle unexpected values
    endcase
end

endmodule
