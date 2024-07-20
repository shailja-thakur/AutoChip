module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    typedef enum {S0, S1, S2, S3, S4, S5, S6, S7, S8, ERR} state_t;
    state_t state, next_state;

    // State transitions
    always @(posedge clk) begin
        if (reset) 
            state <= S0;
        else 
            state <= next_state;
    end

    always @(*) begin
        next_state = state; // Default to stay in current state
        disc = 0;
        flag = 0;
        err = 0;
        
        case (state)
            S0: begin
                if (in == 1)
                    next_state = S1;
            end
            S1: begin
                if (in == 1)
                    next_state = S2;
                else
                    next_state = S0;
            end
            S2: begin
                if (in == 1)
                    next_state = S3;
                else
                    next_state = S0;
            end
            S3: begin
                if (in == 1)
                    next_state = S4;
                else
                    next_state = S0;
            end
            S4: begin
                if (in == 1)
                    next_state = S5;
                else
                    next_state = S0;
            end
            S5: begin
                if (in == 1)
                    next_state = S6;
                else begin
                    disc = 1; // 0111110 detected
                    next_state = S0;
                end
            end
            S6: begin
                if (in == 1)
                    next_state = S7;
                else begin
                    flag = 1; // 01111110 detected
                    next_state = S0;
                end
            end
            S7: begin
                if (in == 1)
                    next_state = ERR;
                else
                    next_state = S0;
            end
            ERR: begin
                err = 1; // Error state for 7 or more 1s
                if (in == 0)
                    next_state = S0;
            end
            default: next_state = S0;
        endcase
    end
endmodule
