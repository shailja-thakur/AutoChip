module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);
    
    // Define the states of the FSM
    typedef enum int {
        S0, S1, S2, S3, S4, S5, S6, S7, S8, S9
    } state_t;
    
    state_t state, next_state;
    
    // State transition on clock edge
    always_ff @(posedge clk) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end
    
    // Define next state logic
    always_comb begin
        // Default values
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
                 else next_state = S0;

            S6: if (in) next_state = S7;
                 else begin
                     disc = 1;
                     next_state = S0;
                end

            S7: if (in) next_state = S8;
                 else begin
                     flag = 1;
                     next_state = S0;
                end

            S8: begin
                err = 1;
                next_state = S8;
            end

            default: next_state = S0;
        endcase
    end

    // Define output logic based on state
    always_ff @(posedge clk) begin
        if (reset) begin
            disc <= 0;
            flag <= 0;
            err <= 0;
        end else begin
            case (state)
                S0, S1, S2, S3, S4, S5, S6, S7, S8: begin
                    // set the outputs directly in the state transition logic
                end
            endcase
        end
    end
endmodule
