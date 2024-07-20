module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // State machine states
    typedef enum logic [1:0] {
        LOW_LEVEL = 2'b00,    // Below s1
        MID_LEVEL = 2'b01,    // Between s2 and s1
        HIGH_LEVEL = 2'b10,   // Between s3 and s2
        FULL_LEVEL = 2'b11    // Above s3
    } state_t;

    state_t state, next_state;
    state_t prev_state;

    // FSM state update
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW_LEVEL;
            prev_state <= LOW_LEVEL;
        end else begin
            state <= next_state;
            prev_state <= state;
        end
    end

    // FSM next state logic
    always_comb begin
        case (state)
            LOW_LEVEL: begin
                if (s[1])
                    next_state = MID_LEVEL;
                else
                    next_state = LOW_LEVEL;
            end

            MID_LEVEL: begin
                if (s[2])
                    next_state = HIGH_LEVEL;
                else if (!s[1])
                    next_state = LOW_LEVEL;
                else
                    next_state = MID_LEVEL;
            end

            HIGH_LEVEL: begin
                if (s[3])
                    next_state = FULL_LEVEL;
                else if (!s[2])
                    next_state = MID_LEVEL;
                else
                    next_state = HIGH_LEVEL;
            end

            FULL_LEVEL: begin
                if (!s[3])
                    next_state = HIGH_LEVEL;
                else
                    next_state = FULL_LEVEL;
            end

            default: next_state = LOW_LEVEL;
        endcase
    end

    // FSM output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            fr1 <= 1;
            fr2 <= 1;
            fr3 <= 1;
            dfr <= 1;
        end else begin
            case (state)
                LOW_LEVEL: begin
                    fr1 <= 1;
                    fr2 <= 1;
                    fr3 <= 1;
                    dfr <= 0;
                end

                MID_LEVEL: begin
                    fr1 <= 1;
                    fr2 <= 1;
                    fr3 <= 0;
                    dfr <= (prev_state == LOW_LEVEL) ? 1 : 0;
                end

                HIGH_LEVEL: begin
                    fr1 <= 1;
                    fr2 <= 0;
                    fr3 <= 0;
                    dfr <= (prev_state == MID_LEVEL) ? 1 : 0;
                end

                FULL_LEVEL: begin
                    fr1 <= 0;
                    fr2 <= 0;
                    fr3 <= 0;
                    dfr <= 0;
                end

                default: begin
                    fr1 <= 0;
                    fr2 <= 0;
                    fr3 <= 0;
                    dfr <= 0;
                end
            endcase
        end
    end

endmodule
