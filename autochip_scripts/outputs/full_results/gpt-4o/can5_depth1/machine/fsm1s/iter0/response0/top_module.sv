module top_module (
	input clk,
	input in,
	input reset,
	output out
);
    
    typedef enum logic [0:0] {STATE_A = 1'b0, STATE_B = 1'b1} state_t;
    state_t state, next_state;
    
    // Combinational logic block to determine the next state
    always @(*) begin
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
            default: next_state = STATE_A; // Default case to avoid latches
        endcase
    end
    
    // Sequential logic block to update the state register with the next state
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= STATE_B; // Reset state
        else
            state <= next_state;
    end
    
    // Output logic
    assign out = (state == STATE_B); // If state == B, out = 1, otherwise out = 0

endmodule
