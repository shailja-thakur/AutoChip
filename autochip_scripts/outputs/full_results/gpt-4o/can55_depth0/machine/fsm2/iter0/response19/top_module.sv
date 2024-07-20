module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // Define the states
    typedef enum logic [1:0] {STATE_A = 1'b0, STATE_B = 1'b1} state_t;
    state_t state, next_state;

    // Combinational logic to determine the next state
    always @(*) begin
        case (state)
            STATE_A: begin
                if (j) 
                    next_state = STATE_B;
                else 
                    next_state = STATE_A;
            end
            STATE_B: begin
                if (k) 
                    next_state = STATE_A;
                else 
                    next_state = STATE_B;
            end
            default: next_state = STATE_A; // Default/reset state
        endcase
    end

    // Sequential logic for state update
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= STATE_A;
        else 
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        out = (state == STATE_B);
    end

endmodule
