module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    // State encoding
    typedef enum reg [3:0] {
        STATE_A = 4'd0,
        STATE_B = 4'd1,
        STATE_C = 4'd2,
        STATE_S10 = 4'd3,
        STATE_S11 = 4'd4,
        STATE_S20 = 4'd5,
        STATE_S21 = 4'd6,
        STATE_S22 = 4'd7
    } state_t;
    
    state_t current_state, next_state;
    
    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_A:
                if (s) next_state = STATE_B;
                else next_state = STATE_A;
            
            STATE_B:
                if (w) next_state = STATE_S11;
                else next_state = STATE_S10;
                
            STATE_C:
                if (w) next_state = STATE_S11;
                else next_state = STATE_S10;
                
            STATE_S10:
                if (w) next_state = STATE_S21;
                else next_state = STATE_S20;
                
            STATE_S11:
                if (w) next_state = STATE_S22;
                else next_state = STATE_S21;
                
            STATE_S20:
                next_state = STATE_B;
                
            STATE_S21:
                if (w) next_state = STATE_C;
                else next_state = STATE_B;
                
            STATE_S22:
                if (w) next_state = STATE_B;
                else next_state = STATE_C;

            default: next_state = STATE_A;
        endcase
    end
    
    // State register
    always @(posedge clk or posedge reset) begin
        if (reset) current_state <= STATE_A;
        else current_state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        z = (current_state == STATE_S20) || (current_state == STATE_S21) || (current_state == STATE_S22);
    end

endmodule
