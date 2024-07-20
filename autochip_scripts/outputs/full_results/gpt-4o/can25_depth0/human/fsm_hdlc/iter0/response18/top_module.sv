module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    typedef enum logic [2:0] {
        STATE_IDLE,
        STATE_ONE,
        STATE_TWO,
        STATE_THREE,
        STATE_FOUR,
        STATE_FIVE,
        STATE_SIX,
        STATE_SEVEN,
        STATE_ERROR
    } state_t;

    state_t current_state, next_state;
    logic add_zero_detected;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= STATE_IDLE;
            disc <= 0;
            flag <= 0;
            err <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        next_state = current_state; // Default to no state change
        disc = 0;
        flag = 0;
        err = 0;
        
        case (current_state)
            STATE_IDLE: begin
                if (in) next_state = STATE_ONE;
            end
            
            STATE_ONE: begin
                if (in) next_state = STATE_TWO;
                else next_state = STATE_IDLE;
            end
            
            STATE_TWO: begin
                if (in) next_state = STATE_THREE;
                else next_state = STATE_IDLE;
            end
            
            STATE_THREE: begin
                if (in) next_state = STATE_FOUR;
                else next_state = STATE_IDLE;
            end
            
            STATE_FOUR: begin
                if (in) next_state = STATE_FIVE;
                else next_state = STATE_IDLE;
            end
            
            STATE_FIVE: begin
                if (in) next_state = STATE_SIX;
                else next_state = STATE_IDLE;
            end
            
            STATE_SIX: begin
                if (in) next_state = STATE_SEVEN;
                else begin
                    disc = 1;
                    next_state = STATE_IDLE;
                end
            end
            
            STATE_SEVEN: begin
                if (in) begin
                    err = 1;
                    next_state = STATE_ERROR;
                end else begin
                    flag = 1;
                    next_state = STATE_IDLE;
                end
            end
            
            STATE_ERROR: begin
                // Remain in error state indefinitely until reset
            end
            
            default: begin
                next_state = STATE_IDLE;
            end
        endcase
    end
endmodule
