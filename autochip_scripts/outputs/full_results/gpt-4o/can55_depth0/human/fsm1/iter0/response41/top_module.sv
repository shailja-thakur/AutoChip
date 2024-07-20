module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

    // State Encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;
    
    state_t state, next_state;

    // State Register with Asynchronous Reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_B;
        else
            state <= next_state;
    end

    // Next State Logic
    always_comb begin
        case (state)
            STATE_A: next_state = (in) ? STATE_A : STATE_B;
            STATE_B: next_state = (in) ? STATE_B : STATE_A;
            default: next_state = STATE_B; // Default to state B for safety
        endcase
    end

    // Output Logic
    always_comb begin
        case (state)
            STATE_A: out = 0;
            STATE_B: out = 1;
            default: out = 1; // Default Output for unknown state
        endcase
    end

endmodule
