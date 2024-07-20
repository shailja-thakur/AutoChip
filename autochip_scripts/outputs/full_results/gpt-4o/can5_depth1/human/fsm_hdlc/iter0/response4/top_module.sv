module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    // State encoding
    typedef enum logic [2:0] {
        S0,   // No consecutive 1s
        S1,   // 1 consecutive 1
        S2,   // 2 consecutive 1s
        S3,   // 3 consecutive 1s
        S4,   // 4 consecutive 1s
        S5,   // 5 consecutive 1s
        S6,   // 6 consecutive 1s
        S7    // 7 or more consecutive 1s (Error)
    } state_t;

    state_t state, next_state;
    
    // Next state and output logic
    always_comb begin
        // Default assignments
        next_state = state;
        disc = 0;
        flag = 0;
        err = 0;
        
        case (state)
            S0: 
                if (in) next_state = S1;
            
            S1:
                if (in) next_state = S2;
                else    next_state = S0;
                
            S2:
                if (in) next_state = S3;
                else    next_state = S0;
                
            S3:
                if (in) next_state = S4;
                else    next_state = S0;

            S4:
                if (in) next_state = S5;
                else    next_state = S0;
                
            S5:
                if (in) next_state = S6;
                else    next_state = S0;
                
            S6:
                if (in) begin
                    next_state = S7;
                    err = 1;
                end else begin
                    next_state = S0;
                    flag = 1;
                end
                
            S7:
                if (in) begin
                    next_state = S7;
                    err = 1;
                end else begin
                    next_state = S0;
                    disc = 1;
                end
                
            default: 
                next_state = S0;
        endcase
    end
    
    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) 
            state <= S0;
        else 
            state <= next_state;
    end

endmodule
