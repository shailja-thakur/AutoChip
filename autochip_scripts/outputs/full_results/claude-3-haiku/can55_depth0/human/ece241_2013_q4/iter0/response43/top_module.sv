module top_module (
    input clk,
    input reset,
    input [3:1] s, // Sensor inputs
    output reg fr3, // Nominal flow rate 3
    output reg fr2, // Nominal flow rate 2
    output reg fr1, // Nominal flow rate 1
    output reg dfr  // Increase flow rate
);

reg [1:0] state;
parameter ABOVE_S3 = 2'd0, BETWEEN_S3_S2 = 2'd1, BETWEEN_S2_S1 = 2'd2, BELOW_S1 = 2'd3;

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
            ABOVE_S3: begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
                if (s[3:1] == 3'b111) begin
                    state <= ABOVE_S3;
                end
                else if (s[3:1] == 3'b110) begin
                    state <= BETWEEN_S3_S2;
                end
                else if (s[3:1] == 3'b100) begin
                    state <= BETWEEN_S2_S1;
                end
                else begin
                    state <= BELOW_S1;
                end
            end
            BETWEEN_S3_S2: begin
                fr3 <= 1'b0;
                fr2 <= 1'b1;
                fr1 <= 1'b0;
                dfr <= 1'b0;
                if (s[3:1] == 3'b110) begin
                    state <= BETWEEN_S3_S2;
                end
                else if (s[3:1] == 3'b100) begin
                    state <= BETWEEN_S2_S1;
                end
                else begin
                    state <= BELOW_S1;
                end
            end
            BETWEEN_S2_S1: begin
                fr3 <= 1'b0;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b0;
                if (s[3:1] == 3'b100) begin
                    state <= BETWEEN_S2_S1;
                end
                else begin
                    state <= BELOW_S1;
                end
            end
            BELOW_S1: begin
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
                if (s[3:1] == 3'b000) begin
                    state <= BELOW_S1;
                end
                else if (s[3:1] == 3'b100) begin
                    state <= BETWEEN_S2_S1;
                end
                else if (s[3:1] == 3'b110) begin
                    state <= BETWEEN_S3_S2;
                end
                else begin
                    state <= ABOVE_S3;
                end
            end
        endcase
    end
end

endmodule
