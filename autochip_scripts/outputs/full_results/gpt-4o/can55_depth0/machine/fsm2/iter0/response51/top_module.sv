module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    
    // State encoding
    typedef enum logic [0:0] {STATE_A = 1'b0, STATE_B = 1'b1} state_t;
    state_t current_state, next_state;
    
    // Combinational logic to determine next state
    always @(*) begin
        case (current_state)
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
            default: next_state = STATE_A; // default state
        endcase
    end
    
    // Sequential logic for state update and asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        case (current_state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b1;
            default: out = 1'b0;
        endcase
    end
    
endmodule
