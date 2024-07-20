module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    typedef enum logic [2:0] {
        STATE_LOW = 3'b000,
        STATE_S1 = 3'b001,
        STATE_S2 = 3'b010,
        STATE_S3 = 3'b011,
        STATE_EMPTY = 3'b100
    } state_t;

    state_t state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= STATE_LOW;
        else
            state <= next_state;
    end

    always_comb begin
        // Default values
        fr3 = 0;
        fr2 = 0;
        fr1 = 0;
        dfr = 0;

        case (state)
            STATE_LOW: begin
                if (s[1] == 0)
                    next_state = STATE_LOW;
                else
                    next_state = STATE_S1;
                fr3 = 1;
                fr2 = 1;
                fr1 = 1;
                dfr = 1;
            end

            STATE_S1: begin
                if (s[2] == 0)
                    next_state = STATE_S1;
                else if (s[3] == 0)
                    next_state = STATE_S2;
                else
                    next_state = STATE_S3;
                fr2 = 1;
                fr1 = 1;
            end

            STATE_S2: begin
                if (s[3] == 0)
                    next_state = STATE_S2;
                else
                    next_state = STATE_S3;
                fr1 = 1;
            end

            STATE_S3: begin
                if (s[3] == 1)
                    next_state = STATE_S3;
                else if (s[2] == 1)
                    next_state = STATE_S2;
                else if (s[1] == 1)
                    next_state = STATE_S1;
                else
                    next_state = STATE_LOW;
            end

            default: begin
                next_state = STATE_LOW;
            end
        endcase

        // Control dfr based on state transitions:
        if (state == STATE_S1 && next_state == STATE_S2) begin
            dfr = 1;
        end else begin
            dfr = 0;
        end
    end
endmodule
