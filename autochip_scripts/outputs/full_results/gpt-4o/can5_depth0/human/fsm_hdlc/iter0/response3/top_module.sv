module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    typedef enum logic [2:0] {
        S0,  // initial state
        S1,  // after 1st '1'
        S2,  // after 2nd '1'
        S3,  // after 3rd '1'
        S4,  // after 4th '1'
        S5,  // after 5th '1'
        S6,  // after 6th '1'
        ERR  // error state
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        next_state = state;  // Default is to stay in the same state
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;
        
        case (state)
            S0: begin
                if (in)
                    next_state = S1;
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
                    next_state = S0;
            end
            
            S6: begin
                if (in) begin
                    err = 1'b1;
                    next_state = ERR; // Error state for 7 or more consecutive 1s
                end else begin
                    disc = 1'b1;
                    next_state = S0;
                end
            end
            
            ERR: begin // Remain in error state until reset
                err = 1'b1;
            end
        endcase

        // Flag logic (detecting 01111110 pattern)
        if (state == S5 && next_state == S0 && in == 1'b0) begin
            flag = 1'b1;
        end
    end

endmodule
