module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [1:0] state, next_state;
parameter [1:0] STATE_LOW = 2'b00,
                STATE_MEDIUM = 2'b01,
                STATE_HIGH = 2'b10,
                STATE_ABOVE_MAX = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_LOW;
        fr3 <= 1;
        fr2 <= 1;
        fr1 <= 1;
        dfr <= 1;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    fr3 = 0;
    fr2 = 0;
    fr1 = 0;
    dfr = 0;

    case (state)
        STATE_LOW: begin
            if (s[1] && !s[2] && !s[3]) begin
                next_state = STATE_MEDIUM;
                fr1 = 1;
                fr2 = 1;
            end
            else if (!s[1] && !s[2] && !s[3]) begin
                fr1 = 1;
                fr2 = 1;
                fr3 = 1;
            end
        end
        STATE_MEDIUM: begin
            if (s[1] && s[2] && !s[3]) begin
                next_state = STATE_HIGH;
                fr1 = 1;
            end
            else if (!s[1] && !s[2] && !s[3]) begin
                next_state = STATE_LOW;
                fr1 = 1;
                fr2 = 1;
                fr3 = 1;
                dfr = 1;
            end
        end
        STATE_HIGH: begin
            if (s[1] && s[2] && s[3]) begin
                next_state = STATE_ABOVE_MAX;
            end
            else if (s[1] && !s[2] && !s[3]) begin
                next_state = STATE_MEDIUM;
                fr1 = 1;
                fr2 = 1;
            end
        end
        STATE_ABOVE_MAX: begin
            if (!s[1] && !s[2] && !s[3]) begin
                next_state = STATE_LOW;
                fr1 = 1;
                fr2 = 1;
                fr3 = 1;
                dfr = 1;
            end
        end
    endcase
end

endmodule
