module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    typedef enum reg [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_S10 = 3'b011,
        STATE_S11 = 3'b100,
        STATE_S20 = 3'b101,
        STATE_S21 = 3'b110,
        STATE_S22 = 3'b111
    } state_t;
    
    reg [2:0] state, next_state;
    
    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            STATE_A: 
                if (s)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
                    
            STATE_B: 
                if (w)
                    next_state = STATE_S11;
                else
                    next_state = STATE_S10;
                    
            STATE_C: 
                if (w)
                    next_state = STATE_S11;
                else
                    next_state = STATE_S10;
                    
            STATE_S10: 
                if (w)
                    next_state = STATE_S21;
                else
                    next_state = STATE_S20;
                    
            STATE_S11: 
                if (w)
                    next_state = STATE_S22;
                else
                    next_state = STATE_S21;
                    
            STATE_S20: 
                next_state = STATE_B;
                
            STATE_S21: 
                if (w)
                    next_state = STATE_C;
                else
                    next_state = STATE_B;
                    
            STATE_S22: 
                if (w)
                    next_state = STATE_B;
                else
                    next_state = STATE_C;
                    
            default: 
                next_state = STATE_A;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            z <= 0;
        else 
            z <= (state == STATE_S22);
    end

endmodule
