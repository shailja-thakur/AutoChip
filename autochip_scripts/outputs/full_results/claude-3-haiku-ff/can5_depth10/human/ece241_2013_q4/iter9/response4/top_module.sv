module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [1:0] state;
parameter STATE_ABOVE_S3 = 2'b00,
          STATE_BETWEEN_S3_S2 = 2'b01,
          STATE_BETWEEN_S2_S1 = 2'b10,
          STATE_BELOW_S1 = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_BELOW_S1;
        fr3 <= 1;
        fr2 <= 1;
        fr1 <= 1;
        dfr <= 1;
    end
    else begin
        case (state)
            STATE_ABOVE_S3: begin
                if (s[3]) begin
                    state <= STATE_ABOVE_S3;
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 0;
                    dfr <= 0;
                end
                else if (s[2]) begin
                    state <= STATE_BETWEEN_S3_S2;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 0;
                end
                else begin
                    state <= STATE_BETWEEN_S2_S1;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 0;
                end
            end
            STATE_BETWEEN_S3_S2: begin
                if (s[3]) begin
                    state <= STATE_ABOVE_S3;
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 0;
                    dfr <= 0;
                end
                else if (s[2]) begin
                    state <= STATE_BETWEEN_S3_S2;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 0;
                end
                else begin
                    state <= STATE_BETWEEN_S2_S1;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
            end
            STATE_BETWEEN_S2_S1: begin
                if (s[3]) begin
                    state <= STATE_ABOVE_S3;
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 0;
                    dfr <= 0;
                end
                else if (s[2]) begin
                    state <= STATE_BETWEEN_S3_S2;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 0;
                end
                else if (s[1]) begin
                    state <= STATE_BETWEEN_S2_S1;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
                else begin
                    state <= STATE_BELOW_S1;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
            end
            STATE_BELOW_S1: begin
                if (s[3]) begin
                    state <= STATE_ABOVE_S3;
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 0;
                    dfr <= 0;
                end
                else if (s[2]) begin
                    state <= STATE_BETWEEN_S3_S2;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 0;
                end
                else if (s[1]) begin
                    state <= STATE_BETWEEN_S2_S1;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
                else begin
                    state <= STATE_BELOW_S1;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
            end
        endcase
    end
end

endmodule
