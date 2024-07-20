module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    typedef enum logic [1:0] {
        STATE_LOW = 2'b00,  // No sensors asserted
        STATE_MID_LOW = 2'b01,  // s1 asserted
        STATE_MID_HIGH = 2'b10,  // s1 and s2 asserted
        STATE_HIGH = 2'b11  // s1, s2, and s3 asserted
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= STATE_LOW;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        // Default values for the outputs
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b0;
        dfr = 1'b0;

        case (state)
            STATE_LOW: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                fr3 = 1'b1;
                if (s[1]) begin
                    next_state = STATE_MID_LOW;
                end else begin
                    next_state = STATE_LOW;
                end
            end

            STATE_MID_LOW: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                if (s[2]) begin
                    next_state = STATE_MID_HIGH;
                end else if (!s[1]) begin
                    next_state = STATE_LOW;
                end else begin
                    next_state = STATE_MID_LOW;
                end
            end

            STATE_MID_HIGH: begin
                fr1 = 1'b1;
                if (s[3]) begin
                    next_state = STATE_HIGH;
                end else if (!s[2]) begin
                    next_state = STATE_MID_LOW;
                end else begin
                    next_state = STATE_MID_HIGH;
                end
            end

            STATE_HIGH: begin
                if (!s[3]) begin
                    next_state = STATE_MID_HIGH;
                end else begin
                    next_state = STATE_HIGH;
                end
            end

            default: begin
                next_state = STATE_LOW;
            end
        endcase

        // Determine dfr based on water level changes
        if ((state == STATE_LOW && next_state == STATE_MID_LOW) ||
            (state == STATE_MID_LOW && next_state == STATE_MID_HIGH) ||
            (state == STATE_MID_HIGH && next_state == STATE_HIGH)) begin
            dfr = 1'b1;
        end
    end

endmodule
