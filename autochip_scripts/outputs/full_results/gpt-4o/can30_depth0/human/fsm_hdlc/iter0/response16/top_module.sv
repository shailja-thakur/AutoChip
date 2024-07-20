module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    typedef enum reg [2:0] {
        S0, // initial state
        S1, // saw one 0
        S2, // saw 01
        S3, // saw 011
        S4, // saw 0111
        S5, // saw 01111
        S6, // saw 011111 (5 consecutive ones)
        S7, // saw 0111111 (6 consecutive ones)
        S8  // saw 01111111 (error state, 7 consecutive ones)
    } state_t;

    state_t current_state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        // Default outputs
        disc = 0;
        flag = 0;
        err = 0;

        case (current_state)
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
                if (in)
                    next_state = S7;
                else
                    next_state = S0;
                    disc = 1; // detected 0111110
            end
            S7: begin
                if (in)
                    next_state = S8;
                else
                    next_state = S0;
                    flag = 1; // detected 01111110
            end
            S8: begin
                if (in)
                    next_state = S8;
                    err = 1; // detected 01111111...
                else
                    next_state = S0;
            end
            default: next_state = S0;
        endcase
    end

endmodule
