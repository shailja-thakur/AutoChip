module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    // Define the states
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    state_t state, next_state;

    // Combinational block to determine the next state
    always_comb begin
        case (state)
            STATE_A: 
                if (j) 
                    next_state = STATE_B;
                else 
                    next_state = STATE_A;
            STATE_B: 
                if (k) 
                    next_state = STATE_A;
                else 
                    next_state = STATE_B;
            default: 
                next_state = STATE_A; // default state
        endcase
    end

    // Sequential block to update the state
    always_ff @(posedge clk or posedge areset) begin
        if (areset) 
            state <= STATE_A;
        else 
            state <= next_state;
    end

    // Output logic
    always_comb begin
        out = (state == STATE_B);
    end
    
endmodule
