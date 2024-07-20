module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    typedef enum logic [2:0] {
        S0,  // Initial state, acts as though previous input was 0
        S1,  // 0 -> Seen 1
        S2,  // 01 -> Seen 11
        S3,  // 011 -> Seen 111
        S4,  // 0111 -> Seen 1111
        S5,  // 01111 -> Seen 11111
        S6,  // 011111 -> Seen 111111
        S7   // 0111111 -> Seen 1111111 (error state)
    } state_t;
    state_t state, next_state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

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
                if (in) next_state = S7;
                else next_state = S0;
                err = 1;
            end
        endcase
    end

endmodule
