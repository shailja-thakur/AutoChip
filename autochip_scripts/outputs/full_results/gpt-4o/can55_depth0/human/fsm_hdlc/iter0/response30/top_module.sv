module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
    );

    typedef enum logic [2:0] {
        S_IDLE,      // Idle state where the previous input is considered 0 (after reset or no significant sequence)
        S_1,         // Detected 1 consecutive 1s
        S_2,         // Detected 2 consecutive 1s
        S_3,         // Detected 3 consecutive 1s
        S_4,         // Detected 4 consecutive 1s
        S_5,         // Detected 5 consecutive 1s
        S_6,         // Detected 6 consecutive 1s, which could be disc or flag
        S_7          // Detected 7 consecutive 1s meaning error
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk) begin
        if (reset)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    always_comb begin
        next_state = state;
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;
        case (state)
            S_IDLE: begin
                if (in == 1'b1)
                    next_state = S_1;
                else
                    next_state = S_IDLE;
            end
            S_1: begin
                if (in == 1'b1)
                    next_state = S_2;
                else
                    next_state = S_IDLE;
            end
            S_2: begin
                if (in == 1'b1)
                    next_state = S_3;
                else
                    next_state = S_IDLE;
            end
            S_3: begin
                if (in == 1'b1)
                    next_state = S_4;
                else
                    next_state = S_IDLE;
            end
            S_4: begin
                if (in == 1'b1)
                    next_state = S_5;
                else
                    next_state = S_IDLE;
            end
            S_5: begin
                if (in == 1'b1)
                    next_state = S_6;
                else
                    next_state = S_IDLE;
            end
            S_6: begin
                if (in == 1'b0) begin
                    next_state = S_IDLE;
                    disc = 1'b1; // 0111110 detected
                end
                else
                    next_state = S_7;
            end
            S_7: begin
                if (in == 1'b0) begin
                    next_state = S_IDLE;
                    flag = 1'b1; // 01111110 detected
                end
                else begin
                    next_state = S_7;
                    err = 1'b1; // 01111111... detected
                end
            end
        endcase
    end

endmodule
