module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    typedef enum reg [3:0] {
        IDLE,
        S1, S2, S3, S4, S5, S6,
        S7, DISCARD,
        FLAG,
        ERROR
    } state_t;

    state_t state, next_state;

    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state = state;
        disc = 0;
        flag = 0;
        err = 0;

        case(state)
            IDLE: begin
                if (in)
                    next_state = S1;
            end
            S1: begin
                if (in) 
                    next_state = S2;
                else 
                    next_state = IDLE;
            end
            S2: begin
                if (in)
                    next_state = S3;
                else
                    next_state = IDLE;
            end
            S3: begin
                if (in)
                    next_state = S4;
                else
                    next_state = IDLE;
            end
            S4: begin
                if (in)
                    next_state = S5;
                else
                    next_state = IDLE;
            end
            S5: begin
                if (in)
                    next_state = S6;
                else
                    next_state = IDLE;
            end
            S6: begin
                if (in)
                    next_state = S7;
                else
                    next_state = DISCARD;
                    disc = 1; // Discard bit
            end
            S7: begin
                if (in) begin
                    err = 1; // Error 7 consecutive 1s
                    next_state = ERROR;
                end
                else begin
                    flag = 1; // Flag detected
                    next_state = FLAG;
                end
            end
            DISCARD: begin
                next_state = IDLE;
            end
            FLAG: begin
                next_state = IDLE;
            end
            ERROR: begin
                next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule
