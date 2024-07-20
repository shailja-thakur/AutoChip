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
parameter BELOW_S1 = 2'b00, BETWEEN_S1_S2 = 2'b01, BETWEEN_S2_S3 = 2'b10, ABOVE_S3 = 2'b11;
reg prev_s1, prev_s2, prev_s3;

always @(posedge clk) begin
    if (reset) begin
        state <= BELOW_S1;
        fr3 <= 1;
        fr2 <= 1;
        fr1 <= 1;
        dfr <= 0;
        prev_s1 <= 0;
        prev_s2 <= 0;
        prev_s3 <= 0;
    end else begin
        state <= next_state;
        prev_s1 <= s[1];
        prev_s2 <= s[2];
        prev_s3 <= s[3];
    end
end

always @(*) begin
    next_state = state;
    case (state)
        BELOW_S1: begin
            fr3 = 1;
            fr2 = 1;
            fr1 = 1;
            dfr = 1;
            if (s[1]) begin
                next_state = BETWEEN_S1_S2;
            end
        end
        BETWEEN_S1_S2: begin
            fr3 = 0;
            fr2 = 1;
            fr1 = 1;
            dfr = (s[1] && !prev_s1) ? 1 : 0;
            if (!s[1]) begin
                next_state = BELOW_S1;
            end else if (s[2]) begin
                next_state = BETWEEN_S2_S3;
            end
        end
        BETWEEN_S2_S3: begin
            fr3 = 0;
            fr2 = 0;
            fr1 = 1;
            dfr = (s[2] && !prev_s2) ? 1 : 0;
            if (!s[2]) begin
                next_state = BETWEEN_S1_S2;
            end else if (s[3]) begin
                next_state = ABOVE_S3;
            end
        end
        ABOVE_S3: begin
            fr3 = 0;
            fr2 = 0;
            fr1 = 0;
            dfr = (s[3] && !prev_s3) ? 1 : 0;
            if (!s[3]) begin
                next_state = BETWEEN_S2_S3;
            end
        end
    endcase
end

endmodule
