module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);
    typedef enum reg [2:0] {
        S_RESET = 3'd0,
        S_ZERO  = 3'd1,
        S_ONE   = 3'd2,
        S_D1    = 3'd3,
        S_D2    = 3'd4,
        S_D3    = 3'd5,
        S_D4    = 3'd6,
        S_D5    = 3'd7
    } state_t;

    state_t current_state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= S_RESET;
        else
            current_state <= next_state;
    end

    always @(*) begin
        next_state = current_state;
        disc = 0;
        flag = 0;
        err = 0;

        case (current_state)
            S_RESET: begin
                if (in)
                    next_state = S_ONE;
                else
                    next_state = S_ZERO;
            end
            S_ZERO: begin
                if (in)
                    next_state = S_ONE;
                else
                    next_state = S_ZERO;
            end
            S_ONE: begin
                if (in)
                    next_state = S_D1;
                else
                    next_state = S_ZERO;
            end
            S_D1: begin
                if (in)
                    next_state = S_D2;
                else
                    next_state = S_ZERO;
            end
            S_D2: begin
                if (in)
                    next_state = S_D3;
                else
                    next_state = S_ZERO;
            end
            S_D3: begin
                if (in)
                    next_state = S_D4;
                else
                    next_state = S_ZERO;
            end
            S_D4: begin
                if (in)
                    next_state = S_D5;
                else
                    next_state = S_ZERO;
            end
            S_D5: begin
                if (in)
                    next_state = S_D5; // Remain in error state
                else begin
                    next_state = S_ZERO;
                    disc = 1;  // 0111110 detected
                end
            end
            default: begin
                next_state = S_RESET;
            end
        endcase

        if (current_state == S_D5) begin
            if (in) begin
                if (next_state == S_D5)
                    err = 1;  // 0111111... detected
                else
                    flag = 1; // 01111110 detected
            end
        end
    end
endmodule
