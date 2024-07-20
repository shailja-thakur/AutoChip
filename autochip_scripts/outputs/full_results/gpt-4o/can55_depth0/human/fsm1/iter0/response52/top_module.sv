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
    
    // Combinational logic to determine next state
    always_comb begin
        case (state)
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
            default: next_state = STATE_B; // Default to state B for safety
        endcase
    end
    
    // Sequential logic to update the state on the clock edge
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_B;
        else
            state <= next_state;
    end
    
    // Output logic based on state
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            out <= 1'b1;
        else begin
            case (state)
                STATE_A: out <= 1'b0;
                STATE_B: out <= 1'b1;
            endcase
        end
    end
endmodule
