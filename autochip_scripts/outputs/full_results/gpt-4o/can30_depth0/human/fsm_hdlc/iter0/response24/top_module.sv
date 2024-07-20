module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // Define state encoding
    typedef enum logic [2:0] {
        S0, // Initial state
        S1, // 0
        S2, // 01
        S3, // 011
        S4, // 0111
        S5, // 01111
        S6, // 011111
        S7, // 0111111 (possible discard)
        S8  // 01111110 (flag)
    } state_t;

    state_t state, next_state;
    
    // Synchronous state transition
    always_ff @(posedge clk) begin
        if (reset)
            state <= S1;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        // Default assignments
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;
        next_state = state;

        case (state)
            S1: begin
                if (in)
                    next_state = S0;
                else
                    next_state = S2;
            end
            S2: begin
                if (in)
                    next_state = S3;
                else
                    next_state = S2;
            end
            S3: begin
                if (in)
                    next_state = S4;
                else
                    next_state = S2;
            end
            S4: begin
                if (in)
                    next_state = S5;
                else
                    next_state = S2;
            end
            S5: begin
                if (in)
                    next_state = S6;
                else
                    next_state = S2;
            end
            S6: begin
                if (in)
                    next_state = S7;
                else
                    next_state = S2;
            end
            S7: begin
                if (in)
                    next_state = S8;
                else begin
                    next_state = S2;
                    disc = 1;
                end
            end
            S8: begin
                if (in)
                    next_state = S0;
                else begin
                    next_state = S2;
                    flag = 1;
                end
            end
            S0: begin
                if (in) begin
                    next_state = S0;
                    err = 1;
                end
                else
                    next_state = S2;
            end
            default: begin
                next_state = S1;
            end
        endcase
    end

endmodule
