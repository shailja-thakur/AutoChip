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
parameter ABOVE_S3 = 2'b11, BETWEEN_S3_S2 = 2'b10, BETWEEN_S2_S1 = 2'b01, BELOW_S1 = 2'b00;

always @(posedge clk) begin
    if (reset) begin
        state <= BELOW_S1;
        fr3 <= 1;
        fr2 <= 1;
        fr1 <= 1;
        dfr <= 1;
    end
    else begin
        case (state)
            ABOVE_S3: begin
                fr3 <= 0;
                fr2 <= 0;
                fr1 <= 0;
                dfr <= 0;
                if (!s[3]) state <= BETWEEN_S3_S2;
            end
            BETWEEN_S3_S2: begin
                fr3 <= 0;
                fr2 <= 0;
                fr1 <= 1;
                dfr <= 0;
                if (!s[2]) state <= BETWEEN_S2_S1;
                else if (s[3]) state <= ABOVE_S3;
            end
            BETWEEN_S2_S1: begin
                fr3 <= 0;
                fr2 <= 1;
                fr1 <= 1;
                dfr <= 0;
                if (!s[1]) state <= BELOW_S1;
                else if (s[2]) state <= BETWEEN_S3_S2;
            end
            BELOW_S1: begin
                fr3 <= 1;
                fr2 <= 1;
                fr1 <= 1;
                dfr <= 1;
                if (s[1]) state <= BETWEEN_S2_S1;
            end
        endcase
    end
end

endmodule
