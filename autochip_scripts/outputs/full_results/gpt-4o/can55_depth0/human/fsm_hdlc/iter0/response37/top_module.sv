module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // State encoding
    typedef enum logic [3:0] {
        S0,    // Initial state
        S1,    // 0
        S2,    // 01
        S3,    // 011
        S4,    // 0111
        S5,    // 01111
        S6,    // 011111
        S7,    // 0111111
        S8,    // 01111110
        S_ERR  // Error state
    } state_t;
    
    state_t state, next_state;
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic
    always_comb begin
        next_state = state;
        disc = 0;
        flag = 0;
        err = 0;

        case (state)
            S0: begin
                if (in) next_state = S1;
            end
            S1: begin
                if (in) next_state = S_ERR;
                else next_state = S2;
            end
            S2: begin
                if (in) next_state = S3;
                else next_state = S_ERR;
            end
            S3: begin
                if (in) next_state = S4;
                else next_state = S_ERR;
            end
            S4: begin
                if (in) next_state = S5;
                else next_state = S_ERR;
            end
            S5: begin
                if (in) next_state = S6;
                else next_state = S_ERR;
            end
            S6: begin
                if (in) next_state = S7;
                else begin
                    next_state = S0;
                    disc = 1;
                end
            end
            S7: begin
                if (in) next_state = S_ERR;
                else begin
                    next_state = S8;
                    flag = 1;
                end
            end
            S8: begin
                if (in) next_state = S1;
                else next_state = S_ERR;
            end
            S_ERR: begin
                err = 1;
            end
        endcase
    end

endmodule
