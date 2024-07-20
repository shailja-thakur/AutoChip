module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    // State declaration
    typedef enum reg [2:0] {
        S0, // Initial state, expecting 0
        S1, // Seen 0
        S2, // Seen 01
        S3, // Seen 011
        S4, // Seen 0111
        S5, // Seen 01111
        S6, // Seen 011111
        S7, // Seen 0111111
        S8, // Seen 01111111
        ERROR // Error state
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        next_state = state;
        disc = 0;
        flag = 0;
        err = 0;
        case (state)
            S0: next_state = in ? S0 : S1;
            S1: next_state = in ? S2 : S1;
            S2: next_state = in ? S3 : S1;
            S3: next_state = in ? S4 : S1;
            S4: next_state = in ? S5 : S1;
            S5: next_state = in ? S6 : S1;
            S6: begin
                if (in) next_state = S7;
                else begin
                    next_state = S1;
                    disc = 1;
                end
            end
            S7: begin
                if (in) next_state = S8;
                else begin
                    next_state = S1;
                    flag = 1;
                end
            end
            S8: begin
                if (in) begin
                    next_state = ERROR;
                    err = 1;
                end
                else next_state = S1;
            end
            ERROR: begin
                err = 1;
                next_state = reset ? S0 : ERROR;
            end
            default: next_state = S0;
        endcase
    end

    // State update logic
    always @(posedge clk) begin
        if (reset) state <= S0;
        else state <= next_state;
    end

endmodule
