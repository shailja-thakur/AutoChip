module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;
    
    state_t state, next_state;

    // State Transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_B;
        end else begin
            state <= next_state;
        end
    end

    // Next State Logic
    always_comb begin
        case (state)
            STATE_A: if (in) next_state = STATE_A; else next_state = STATE_B;
            STATE_B: if (in) next_state = STATE_B; else next_state = STATE_A;
            default: next_state = STATE_B; // Default to State B for safety
        endcase
    end

    // Output Logic
    always_ff @(posedge clk or posedge areset) begin
        if(areset)
            out <= 1'b1; // State B's output
        else begin
            case (state)
                STATE_A: out <= 1'b0;
                STATE_B: out <= 1'b1;
            endcase
        end
    end
endmodule
