module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    typedef enum reg [2:0] {
        IDLE,
        S1,
        S11,
        S111,
        S1111,
        S11111,
        S111110,
        S1111110,
        S1111111
    } state_t;

    state_t state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        disc = 0;
        flag = 0;
        err = 0;
        next_state = state;

        case (state)
            IDLE: begin
                if (in == 1) begin
                    next_state = S1;
                end
            end
            S1: begin
                if (in == 1) begin
                    next_state = S11;
                end else begin
                    next_state = IDLE;
                end
            end
            S11: begin
                if (in == 1) begin
                    next_state = S111;
                end else begin
                    next_state = IDLE;
                end
            end
            S111: begin
                if (in == 1) begin
                    next_state = S1111;
                end else begin
                    next_state = IDLE;
                end
            end
            S1111: begin
                if (in == 1) begin
                    next_state = S11111;
                end else begin
                    next_state = IDLE;
                end
            end
            S11111: begin
                if (in == 1) begin
                    next_state = S1111110;
                    disc = 1;
                end else begin
                    next_state = IDLE;
                end
            end
            S1111110: begin
                if (in == 1) begin
                    next_state = S1111111;
                    flag = 1;
                end else begin
                    next_state = IDLE;
                end
            end
            S1111111: begin
                if (in == 1) begin
                    next_state = S1111111;
                    err = 1;
                end else begin
                    next_state = IDLE;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule
