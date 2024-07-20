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
        S0,   // Initial state or no consecutive 1s
        S1,   // 1 consecutive 1
        S2,   // 2 consecutive 1s
        S3,   // 3 consecutive 1s
        S4,   // 4 consecutive 1s
        S5,   // 5 consecutive 1s
        S6,   // 6 consecutive 1s (possible flag)
        S7    // 7 or more consecutive 1s (Error)
    } state_t;

    state_t state, next_state;
    
    // State transition and output logic
    always_comb begin
        // Default assignments
        next_state = state;
        disc = 0;
        flag = 0;
        err = 0;
        
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
                    next_state = S0;
            end
                
            S6: begin
                if (in) begin
                    next_state = S7;
                    err = 1;
                end else begin
                    next_state = S0;
                    flag = 1;
                end
            end
                
            S7: begin
                if (in) begin
                    next_state = S7;
                    err = 1;
                end else begin
                    next_state = S0;
                    disc = 1;
                end
            end
                
            default: begin
                next_state = S0;
                disc = 0;
                flag = 0;
                err = 0;
            end
        endcase
    end
    
    // State register
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else 
            state <= next_state;
    end

endmodule
