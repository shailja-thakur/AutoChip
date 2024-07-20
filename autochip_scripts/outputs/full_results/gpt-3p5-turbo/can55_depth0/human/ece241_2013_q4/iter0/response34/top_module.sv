module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [2:0] state;

// Define states
parameter STATE_LOW = 0;
parameter STATE_BETWEEN_1_2 = 1;
parameter STATE_BETWEEN_2_3 = 2;
parameter STATE_ABOVE_3 = 3;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_LOW;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end else begin
        case (state)
            STATE_LOW: begin
                if (s[3]) begin
                    state <= STATE_ABOVE_3;
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end else if (s[2] && !s[3]) begin
                    state <= STATE_BETWEEN_2_3;
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                end else if (s[1] && !s[2] && !s[3]) begin
                    state <= STATE_BETWEEN_1_2;
                    fr3 <= 1'b0;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                end else if (!s[1] && !s[2] && !s[3]) begin
                    state <= STATE_LOW;
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b1;
                end
            end
            STATE_BETWEEN_1_2: begin
                if (s[3]) begin
                    state <= STATE_ABOVE_3;
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end else if (!s[2] && !s[3]) begin
                    state <= STATE_LOW;
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                end
            end
            STATE_BETWEEN_2_3: begin
                if (s[3]) begin
                    state <= STATE_ABOVE_3;
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end else if (s[2] && !s[3]) begin
                    state <= STATE_BETWEEN_2_3;
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                end else if (!s[1] && !s[2] && !s[3]) begin
                    state <= STATE_LOW;
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                end
            end
            STATE_ABOVE_3: begin
                if (!s[3]) begin
                    state <= STATE_BETWEEN_2_3;
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                end
            end
        endcase
    end
end

endmodule
