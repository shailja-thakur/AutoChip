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
                if (s[1] == 1'b1) begin
                    state <= BETWEEN_S1_S2;
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end
                else begin
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b1;
                end
            end
            BETWEEN_S1_S2: begin
                if (s[2] == 1'b1) begin
                    state <= BETWEEN_S2_S3;
                    fr3 <= 1'b1;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end
                else if (s[1] == 1'b0) begin
                    state <= BELOW_S1;
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b1;
                end
                else begin
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end
            end
            BETWEEN_S2_S3: begin
                if (s[3] == 1'b1) begin
                    state <= ABOVE_S3;
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end
                else if (s[2] == 1'b0) begin
                    state <= BETWEEN_S1_S2;
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end
                else begin
                    fr3 <= 1'b1;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end
            end
            ABOVE_S3: begin
                if (s[3] == 1'b0) begin
                    state <= BETWEEN_S2_S3;
                    fr3 <= 1'b1;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end
                else begin
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end
            end
        endcase
    end
end

endmodule
