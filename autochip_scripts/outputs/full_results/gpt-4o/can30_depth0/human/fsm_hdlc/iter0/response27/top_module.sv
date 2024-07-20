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
        S0, // Initial state, equivalent to having seen a previous 0
        S1, // Seen one 1
        S2, // Seen two consecutive 1s
        S3, // Seen three consecutive 1s
        S4, // Seen four consecutive 1s
        S5, // Seen five consecutive 1s
        S6, // Seen six consecutive 1s
        ERR // Error state for seven or more consecutive 1s
    } state_t;

    state_t state, next_state;

    // Synchronous state transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    // Combinational next state logic
    always @(*) begin
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
                else begin
                    next_state = S0;
                    disc = 1;
                end
            end
            S6: begin
                if (in) begin
                    next_state = ERR;
                    err = 1;
                end else begin
                    next_state = S0;
                    flag = 1;
                end
            end
            ERR: begin
                if (in)
                    next_state = ERR;
                else
                    next_state = S0;
            end
            default: next_state = S0;
        endcase
    end
endmodule
