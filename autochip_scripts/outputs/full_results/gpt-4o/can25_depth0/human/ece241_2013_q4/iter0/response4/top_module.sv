module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // State encoding
    reg [1:0] state, next_state;
    reg prev_level_below;

    localparam STATE_LOW = 2'd0;
    localparam STATE_BETWEEN_S1_S2 = 2'd1;
    localparam STATE_BETWEEN_S2_S3 = 2'd2;
    localparam STATE_HIGH = 2'd3;

    // State transition logic
    always @(*) begin
        case (state)
            STATE_LOW: begin
                if (s[3] && s[2] && s[1])
                    next_state = STATE_HIGH;
                else if (s[2] && s[1])
                    next_state = STATE_BETWEEN_S2_S3;
                else if (s[1])
                    next_state = STATE_BETWEEN_S1_S2;
                else
                    next_state = STATE_LOW;
            end
            STATE_BETWEEN_S1_S2: begin
                if (s[3] && s[2] && s[1])
                    next_state = STATE_HIGH;
                else if (s[2] && s[1])
                    next_state = STATE_BETWEEN_S2_S3;
                else if (!s[1])
                    next_state = STATE_LOW;
                else
                    next_state = STATE_BETWEEN_S1_S2;
            end
            STATE_BETWEEN_S2_S3: begin
                if (s[3] && s[2] && s[1])
                    next_state = STATE_HIGH;
                else if (!s[2])
                    next_state = STATE_BETWEEN_S1_S2;
                else if (!s[1])
                    next_state = STATE_LOW;
                else
                    next_state = STATE_BETWEEN_S2_S3;
            end
            STATE_HIGH: begin
                if (!s[3])
                    next_state = STATE_BETWEEN_S2_S3;
                else if (!s[2])
                    next_state = STATE_BETWEEN_S1_S2;
                else if (!s[1])
                    next_state = STATE_LOW;
                else
                    next_state = STATE_HIGH;
            end
            default: next_state = STATE_LOW;
        endcase
    end

    // Output logic
    always @(*) begin
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b0;
        dfr = 1'b0;
        case (state)
            STATE_LOW: begin
                fr3 = 1'b1;
                fr2 = 1'b1;
                fr1 = 1'b1;
            end
            STATE_BETWEEN_S1_S2: begin
                fr2 = 1'b1;
                fr1 = 1'b1;
                if (prev_level_below)
                    dfr = 1'b1;
            end
            STATE_BETWEEN_S2_S3: begin
                fr1 = 1'b1;
                if (prev_level_below)
                    dfr = 1'b1;
            end
            STATE_HIGH: begin
                // No flow rates asserted
            end
        endcase
    end

    // State memory and previous level tracking
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= STATE_LOW;
            prev_level_below <= 1'b1;
        end else begin
            state <= next_state;
            if (state == STATE_LOW && next_state != STATE_LOW)
                prev_level_below <= 1'b1;
            else if (next_state == STATE_LOW)
                prev_level_below <= 1'b0;
        end
    end
endmodule
