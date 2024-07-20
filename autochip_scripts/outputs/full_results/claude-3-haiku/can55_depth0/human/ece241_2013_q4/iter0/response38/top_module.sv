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
        fr3 <= 1;
        fr2 <= 1;
        fr1 <= 1;
        dfr <= 1;
    end
    else begin
        case (state)
            BELOW_S1: begin
                fr3 <= 1;
                fr2 <= 1;
                fr1 <= 1;
                dfr <= 1;
                if (s[1]) begin
                    state <= BETWEEN_S1_S2;
                end
            end
            BETWEEN_S1_S2: begin
                fr3 <= 0;
                fr2 <= 1;
                fr1 <= 1;
                dfr <= (s[1] & ~s[2]) ? 1 : 0;
                if (~s[1]) begin
                    state <= BELOW_S1;
                end
                else if (s[2]) begin
                    state <= BETWEEN_S2_S3;
                end
            end
            BETWEEN_S2_S3: begin
                fr3 <= 0;
                fr2 <= 0;
                fr1 <= 1;
                dfr <= (s[1] & ~s[2]) ? 1 : 0;
                if (~s[2]) begin
                    state <= BETWEEN_S1_S2;
                end
                else if (s[3]) begin
                    state <= ABOVE_S3;
                end
            end
            ABOVE_S3: begin
                fr3 <= 0;
                fr2 <= 0;
                fr1 <= 0;
                dfr <= 0;
                if (~s[3]) begin
                    state <= BETWEEN_S2_S3;
                end
            end
        endcase
    end
end

endmodule
