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
parameter BELOW_S1 = 2'b00, BETWEEN_S1_S2 = 2'b01, BETWEEN_S2_S3 = 2'b10, ABOVE_S3 = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= BELOW_S1;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end
    else begin
        case (state)
            BELOW_S1: begin
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
                if (s[1]) state <= BETWEEN_S1_S2;
                else if (s[2]) state <= BETWEEN_S2_S3;
                else if (s[3]) state <= ABOVE_S3;
            end
            BETWEEN_S1_S2: begin
                fr3 <= 1'b0;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b0;
                if (!s[1]) state <= BELOW_S1;
                else if (s[2]) state <= BETWEEN_S2_S3;
                else if (s[3]) state <= ABOVE_S3;
            end
            BETWEEN_S2_S3: begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b1;
                dfr <= 1'b0;
                if (!s[1]) state <= BELOW_S1;
                else if (!s[2]) state <= BETWEEN_S1_S2;
                else if (s[3]) state <= ABOVE_S3;
            end
            ABOVE_S3: begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
                if (!s[3]) state <= BETWEEN_S2_S3;
            end
        endcase
    end
end

endmodule
