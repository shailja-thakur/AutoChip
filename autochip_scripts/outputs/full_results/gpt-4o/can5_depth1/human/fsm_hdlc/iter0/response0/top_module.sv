module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    typedef enum reg [2:0] {
        S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, SERR
    } state_t;

    state_t state, next_state;

    always @(posedge clk) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    always @(*) begin
        disc = 0;
        flag = 0;
        err = 0;
        case (state)
            S0: begin
                if (in == 1'b0) next_state = S0;
                else next_state = S1;
            end
            S1: begin
                if (in == 1'b0) next_state = S0;
                else next_state = S2;
            end
            S2: begin
                if (in == 1'b0) next_state = S0;
                else next_state = S3;
            end
            S3: begin
                if (in == 1'b0) next_state = S0;
                else next_state = S4;
            end
            S4: begin
                if (in == 1'b0) next_state = S0;
                else next_state = S5;
            end
            S5: begin
                if (in == 1'b0) next_state = S0;
                else next_state = S6;
            end
            S6: begin
                if (in == 1'b0) begin
                    disc = 1; // 0111110 detected
                    next_state = S0;
                end
                else next_state = S7;
            end
            S7: begin
                if (in == 1'b0) begin
                    flag = 1; // 01111110 detected
                    next_state = S0;
                end
                else next_state = SERR;
            end
            SERR: begin
                err = 1; // 7 or more consecutive 1s detected
                if (in == 1'b0) next_state = S0;
                else next_state = SERR;
            end
            default: next_state = S0;
        endcase
    end
endmodule
