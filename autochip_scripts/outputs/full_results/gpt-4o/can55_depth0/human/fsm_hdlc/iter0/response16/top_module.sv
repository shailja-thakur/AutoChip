module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    typedef enum logic [2:0] {
        IDLE = 3'd0,
        ONE1 = 3'd1,
        TWO1 = 3'd2,
        THREE1 = 3'd3,
        FOUR1 = 3'd4,
        FIVE1 = 3'd5,
        SIX1 = 3'd6,
        SEVEN1 = 3'd7
    } state_t;
    
    state_t state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;
        
        case (state)
            IDLE: begin
                if (in)
                    next_state = ONE1;
                else
                    next_state = IDLE;
            end
            ONE1: begin
                if (in)
                    next_state = TWO1;
                else
                    next_state = IDLE;
            end
            TWO1: begin
                if (in)
                    next_state = THREE1;
                else
                    next_state = IDLE;
            end
            THREE1: begin
                if (in)
                    next_state = FOUR1;
                else
                    next_state = IDLE;
            end
            FOUR1: begin
                if (in)
                    next_state = FIVE1;
                else
                    next_state = IDLE;
            end
            FIVE1: begin
                if (in)
                    next_state = SIX1;
                else
                    next_state = IDLE;
            end
            SIX1: begin
                if (in) begin
                    next_state = SEVEN1;
                end else begin
                    next_state = IDLE;
                    disc = 1'b1;  // Discard bit signal
                end
            end
            SEVEN1: begin
                if (in) begin
                    next_state = SEVEN1;  // Stay in error state
                    err = 1'b1;  // Error signal
                end else begin
                    next_state = IDLE;
                    flag = 1'b1;  // Frame boundary signal
                end
            end
            default: next_state = IDLE;
        endcase
    end
endmodule
