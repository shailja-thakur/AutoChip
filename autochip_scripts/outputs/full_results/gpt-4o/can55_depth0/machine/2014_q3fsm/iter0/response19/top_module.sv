module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    // Define state parameters
    typedef enum logic [2:0] {
        STATE_A,
        STATE_B,
        STATE_C,
        STATE_S10,
        STATE_S11,
        STATE_S20,
        STATE_S21,
        STATE_S22
    } state_t;
    
    state_t current_state, next_state;
    
    // Sequential logic for state transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end
    
    // Combinational logic for next state and output z
    always_comb begin
        z = 0;
        case (current_state)
            STATE_A: begin
                if (s) 
                    next_state = STATE_B;
                else 
                    next_state = STATE_A;
            end 
            STATE_B: begin
                if (w) 
                    next_state = STATE_S11;
                else 
                    next_state = STATE_S10;
            end
            STATE_C: begin
                if (w) 
                    next_state = STATE_S11;
                else 
                    next_state = STATE_S10;
            end
            STATE_S10: begin
                if (w) 
                    next_state = STATE_S21;
                else 
                    next_state = STATE_S20;
            end
            STATE_S11: begin
                if (w) 
                    next_state = STATE_S22;
                else 
                    next_state = STATE_S21;
            end
            STATE_S20: begin
                next_state = STATE_B;
            end
            STATE_S21: begin
                if (w) 
                    next_state = STATE_C;
                else 
                    next_state = STATE_B;
            end
            STATE_S22: begin
                if (w) 
                    next_state = STATE_B;
                else 
                    next_state = STATE_C;
            end
            default: begin
                next_state = STATE_A;
            end
        endcase
    end
endmodule
