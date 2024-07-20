module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // State encoding
    typedef enum logic [3:0] {
        S0, S1, S2, S3, S4, S5, S6, S7, S8
    } state_t;

    state_t state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) 
            state <= S0;
        else 
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = state;
        disc = 0;
        flag = 0;
        err = 0;

        case (state)
            S0: if (in) next_state = S1;
                else next_state = S0;

            S1: if (in) next_state = S2;
                else next_state = S0;

            S2: if (in) next_state = S3;
                else next_state = S0;

            S3: if (in) next_state = S4;
                else next_state = S0;

            S4: if (in) next_state = S5;
                else next_state = S0;

            S5: if (in) next_state = S6;
                else begin
                    next_state = S0;
                    disc = 1;
                end
                
            S6: if (in) next_state = S7;
                else begin
                    next_state = S0;
                    flag = 1;
                end
            
            S7: if (in) next_state = S8;
                else next_state = S0;

            S8: if (in) begin
                    next_state = S8;
                    err = 1;
                end
                else next_state = S0;
                
            default: next_state = S0;
        endcase
    end
    
    // Outputs (based on the state transitions)
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            disc <= 0;
            flag <= 0;
            err <= 0;
        end
        else begin
            disc <= (next_state == S0 && state == S5);
            flag <= (next_state == S0 && state == S6);
            err <= (state == S8 && in);
        end
    end
endmodule
