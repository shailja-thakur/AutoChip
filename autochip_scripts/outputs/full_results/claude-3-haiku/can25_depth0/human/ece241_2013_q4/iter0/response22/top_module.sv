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
parameter ABOVE_s3 = 2'b00, BETWEEN_s3_s2 = 2'b01, BETWEEN_s2_s1 = 2'b10, BELOW_s1 = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= BELOW_s1;
        fr3 <= 1;
        fr2 <= 1;
        fr1 <= 1;
        dfr <= 1;
    end
    else begin
        case (state)
            ABOVE_s3: begin
                if (s[3]) begin
                    state <= ABOVE_s3;
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 0;
                    dfr <= 0;
                end
                else if (s[2]) begin
                    state <= BETWEEN_s3_s2;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 0;
                end
                else if (s[1]) begin
                    state <= BETWEEN_s2_s1;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
                else begin
                    state <= BELOW_s1;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
            end
            BETWEEN_s3_s2: begin
                if (s[3]) begin
                    state <= ABOVE_s3;
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 0;
                    dfr <= 0;
                end
                else if (s[2] && s[1]) begin
                    state <= BETWEEN_s3_s2;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 0;
                end
                else if (s[1]) begin
                    state <= BETWEEN_s2_s1;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
                else begin
                    state <= BELOW_s1;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
            end
            BETWEEN_s2_s1: begin
                if (s[3]) begin
                    state <= ABOVE_s3;
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 0;
                    dfr <= 0;
                end
                else if (s[2]) begin
                    state <= BETWEEN_s3_s2;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 0;
                end
                else if (s[1]) begin
                    state <= BETWEEN_s2_s1;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
                else begin
                    state <= BELOW_s1;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
            end
            BELOW_s1: begin
                if (s[3]) begin
                    state <= ABOVE_s3;
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 0;
                    dfr <= 0;
                end
                else if (s[2]) begin
                    state <= BETWEEN_s3_s2;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 0;
                end
                else if (s[1]) begin
                    state <= BETWEEN_s2_s1;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
                else begin
                    state <= BELOW_s1;
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
