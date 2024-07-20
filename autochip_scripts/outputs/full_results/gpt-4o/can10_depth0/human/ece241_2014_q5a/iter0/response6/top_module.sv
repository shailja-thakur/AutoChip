module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum reg [1:0] {STATE_IDLE, STATE_INVERT, STATE_ADD_ONE} state_t;
    state_t current_state, next_state;
    
    reg flip; // Indicates if we have already seen the first 1 for the 2's complement
    
    // State machine transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_IDLE;
            flip <= 0;
        end else begin
            current_state <= next_state;
        end
    end
    
    // Next state logic and output calculation
    always @(*) begin
        case (current_state)
            STATE_IDLE: begin
                z = x;
                flip = x & ~flip; // Check if the first '1' bit is encountered
                if (reset) 
                    next_state = STATE_IDLE;
                else if (x & ~flip) 
                    next_state = STATE_INVERT; // Start inversion after first '1'
                else 
                    next_state = STATE_IDLE;
            end

            STATE_INVERT: begin
                z = ~x;
                if (reset) 
                    next_state = STATE_IDLE;
                else if (flip) 
                    next_state = STATE_INVERT;
                else
                    next_state = STATE_ADD_ONE; 
            end

            STATE_ADD_ONE: begin
                z = x;
                if (reset) 
                    next_state = STATE_IDLE;
                else 
                    next_state = STATE_ADD_ONE;
            end
            
            default: next_state = STATE_IDLE;
        endcase
    end
endmodule
