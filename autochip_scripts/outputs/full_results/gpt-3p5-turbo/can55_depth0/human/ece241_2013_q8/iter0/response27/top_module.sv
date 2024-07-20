module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);
    
    /////////////////////////////////
    // State declaration
    /////////////////////////////////
    
    typedef enum logic [1:0] {
        STATE_IDLE,
        STATE_1,
        STATE_2,
        STATE_3
    } fsm_state_t;
    
    fsm_state_t state, next_state;
    
    /////////////////////////////////
    // Output assignment
    /////////////////////////////////
    
    always_comb begin
        z = (state == STATE_3);
    end
    
    /////////////////////////////////
    // State transition logic
    /////////////////////////////////
    
    always_ff @(posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            state <= STATE_IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    /////////////////////////////////
    // Next state logic
    /////////////////////////////////
    
    always_comb begin
        case (state)
            STATE_IDLE: begin
                if (x == 1'b1)
                    next_state = STATE_1;
                else
                    next_state = STATE_IDLE;
            end
            
            STATE_1: begin
                if (x == 1'b0)
                    next_state = STATE_2;
                else if (x == 1'b1)
                    next_state = STATE_1;
                else
                    next_state = STATE_IDLE;
            end
            
            STATE_2: begin
                if (x == 1'b1)
                    next_state = STATE_3;
                else if (x == 1'b0)
                    next_state = STATE_2;
                else
                    next_state = STATE_IDLE;
            end
            
            STATE_3: begin
                if (x == 1'b0)
                    next_state = STATE_2;
                else if (x == 1'b1)
                    next_state = STATE_1;
                else
                    next_state = STATE_IDLE;
            end
        endcase
    end
    
endmodule
