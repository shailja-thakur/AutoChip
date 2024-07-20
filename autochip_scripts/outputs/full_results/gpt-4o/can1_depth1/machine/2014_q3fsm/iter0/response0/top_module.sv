module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    typedef enum reg [2:0] {
        ST_A = 3'd0,
        ST_B = 3'd1,
        ST_C = 3'd2,
        ST_S10 = 3'd3,
        ST_S11 = 3'd4,
        ST_S20 = 3'd5,
        ST_S21 = 3'd6,
        ST_S22 = 3'd7
    } state_t;
    
    state_t current_state, next_state;
    
    // State transitions
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= ST_A;
        end else begin
            current_state <= next_state;
        end
    end
    
    // Output logic (example placeholder, if needed)
    always @(current_state) begin
        z = (current_state == ST_S11) || (current_state == ST_S21) || (current_state == ST_S22);
    end
    
    // Next state logic
    always @(*) begin
        case (current_state)
            ST_A: 
                if (s)
                    next_state = ST_B;
                else
                    next_state = ST_A;
            ST_B: 
                if (w)
                    next_state = ST_S11;
                else
                    next_state = ST_S10;
            ST_C: 
                if (w)
                    next_state = ST_S11;
                else
                    next_state = ST_S10;
            ST_S10: 
                if (w)
                    next_state = ST_S21;
                else
                    next_state = ST_S20;
            ST_S11: 
                if (w)
                    next_state = ST_S22;
                else
                    next_state = ST_S21;
            ST_S20:
                next_state = ST_B;
            ST_S21: 
                if (w)
                    next_state = ST_C;
                else
                    next_state = ST_B;
            ST_S22: 
                if (w)
                    next_state = ST_B;
                else
                    next_state = ST_C;
            default: 
                next_state = ST_A;
        endcase
    end

endmodule
