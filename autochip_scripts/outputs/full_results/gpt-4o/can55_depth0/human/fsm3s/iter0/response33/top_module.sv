module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;
    
    state_t present_state, next_state;
    
    // State transition logic
    always @(*) begin
        case (present_state)
            STATE_A: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_C;
            end
            STATE_C: begin
                if (in)
                    next_state = STATE_D;
                else
                    next_state = STATE_A;
            end
            STATE_D: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_C;
            end
            default: begin
                next_state = STATE_A;
            end
        endcase
    end
    
    // Output logic
    always @(*) begin
        case (present_state)
            STATE_D: out = 1;
            default: out = 0;
        endcase
    end
    
    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            present_state <= STATE_A;
        else
            present_state <= next_state;
    end

endmodule
