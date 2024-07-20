module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum reg {STATE_ZERO, STATE_ONE} state_t;
    state_t current_state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= STATE_ZERO;
        else
            current_state <= next_state;
    end

    always @(*) begin
        case (current_state)
            STATE_ZERO: begin
                if (x)
                    next_state = STATE_ONE;
                else
                    next_state = STATE_ZERO;
            end

            STATE_ONE: begin
                next_state = STATE_ONE;
            end
            
            default: 
                next_state = STATE_ZERO;
        endcase
    end
    
    always @(posedge clk or posedge areset) begin
        if (areset) 
            z <= 1'b0;
        else if (current_state == STATE_ONE)
            z <= ~x;
        else
            z <= x;
    end

endmodule
