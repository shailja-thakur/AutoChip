module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);
    
    // State Encoding
    typedef enum logic [3:0] {
        S0, S1, S2, S3, S4, S5, S6, 
        DISCARD, FLAG, ERROR
    } state_t;

    state_t state, next_state;
    
    // State Update Logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end
    
    // Next State Logic
    always_comb begin
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;
        
        case (state)
            S0: begin
                if (in)
                    next_state = S1;
                else
                    next_state = S0;
            end
            S1: begin
                if (in)
                    next_state = S2;
                else
                    next_state = S0;
            end
            S2: begin
                if (in)
                    next_state = S3;
                else
                    next_state = S0;
            end
            S3: begin
                if (in)
                    next_state = S4;
                else
                    next_state = S0;
            end
            S4: begin
                if (in)
                    next_state = S5;
                else
                    next_state = S0;
            end
            S5: begin
                if (in)
                    next_state = S6;
                else
                    next_state = DISCARD; // 0111110 detected
            end
            S6: begin
                if (in)
                    next_state = ERROR; // Too many consecutive 1s
                else
                    next_state = FLAG; // 01111110 detected
            end
            DISCARD: begin
                disc = 1'b1;
                next_state = S0;
            end
            FLAG: begin
                flag = 1'b1;
                next_state = S0;
            end
            ERROR: begin
                err = 1'b1;
                next_state = S0;
            end
            default: next_state = S0;
        endcase
    end
endmodule
