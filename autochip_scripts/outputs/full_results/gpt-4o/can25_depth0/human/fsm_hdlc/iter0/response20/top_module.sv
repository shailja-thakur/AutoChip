module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // States of the state machine
    typedef enum {S0, S1, S2, S3, S4, S5, S6, S7, S8} state_t;
    state_t state, next_state;

    always @ (posedge clk) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    always @ (*) begin
        // Default outputs
        disc = 0;
        flag = 0;
        err = 0;

        // Determine next state and outputs
        case (state)
            S0: begin
                if (in) next_state = S1;
                else next_state = S0;
            end
            S1: begin
                if (in) next_state = S2;
                else next_state = S0;
            end
            S2: begin
                if (in) next_state = S3;
                else next_state = S0;
            end
            S3: begin
                if (in) next_state = S4;
                else next_state = S0;
            end
            S4: begin
                if (in) next_state = S5;
                else next_state = S0;
            end
            S5: begin
                if (in) next_state = S6;
                else begin 
                    next_state = S0;
                    disc = 1;
                end
            end
            S6: begin
                if (in) next_state = S7;
                else begin
                    next_state = S0;
                    flag = 1;
                end
            end
            S7: begin
                if (in) next_state = S8;
                else next_state = S0;
            end
            S8: begin
                if (in) begin
                    next_state = S8;
                    err = 1;
                end
                else next_state = S0;
            end
            default: next_state = S0;
        endcase
    end

endmodule
