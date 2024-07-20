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
        S0,    // Initial/Reset state (previous input was 0)
        S1,    // Seen 1
        S11,   // Seen 11
        S111,  // Seen 111
        S1111, // Seen 1111
        S11111,// Seen 11111
        S111110,// Seen 111110
        S111111,// Seen 111111
        ERROR  // Error state
    } state_t;

    state_t state, next_state;

    // Sequential logic for state transitions
    always @(posedge clk) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    // Combinational logic for next state and outputs
    always @(*) begin
        // Default outputs
        disc = 0;
        flag = 0;
        err = 0;
        next_state = state;

        case (state)
            S0: begin
                if (in)
                    next_state = S1;
            end
            S1: begin
                if (in)
                    next_state = S11;
                else
                    next_state = S0;
            end
            S11: begin
                if (in)
                    next_state = S111;
                else
                    next_state = S0;
            end
            S111: begin
                if (in)
                    next_state = S1111;
                else
                    next_state = S0;
            end
            S1111: begin
                if (in)
                    next_state = S11111;
                else
                    next_state = S0;
            end
            S11111: begin
                if (in)
                    next_state = S111110;
                else
                    next_state = S0;
            end
            S111110: begin
                if (in) begin
                    next_state = S111111;
                    flag = 1;
                end
                else begin
                    next_state = S0;
                    disc = 1;
                end
            end
            S111111: begin
                if (in) begin
                    next_state = ERROR;
                    err = 1;
                end
                else
                    next_state = S0;
            end
            ERROR: begin
                if (~in)
                    next_state = S0;
            end
        endcase
    end
endmodule
