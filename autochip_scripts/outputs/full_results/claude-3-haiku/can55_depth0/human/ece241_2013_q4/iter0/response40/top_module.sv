module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

localparam LEVEL_ABOVE_S3 = 3'b111;
localparam LEVEL_BETWEEN_S3_S2 = 3'b110;
localparam LEVEL_BETWEEN_S2_S1 = 3'b100;
localparam LEVEL_BELOW_S1 = 3'b000;

reg [2:0] current_level;
reg [2:0] prev_level;

always @(posedge clk) begin
    if (reset) begin
        current_level <= LEVEL_BELOW_S1;
        prev_level <= LEVEL_BELOW_S1;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end else begin
        if (s[3]) begin
            current_level <= LEVEL_ABOVE_S3;
        end else if (s[2]) begin
            current_level <= LEVEL_BETWEEN_S3_S2;
        end else if (s[1]) begin
            current_level <= LEVEL_BETWEEN_S2_S1;
        end else begin
            current_level <= LEVEL_BELOW_S1;
        end

        if (current_level > prev_level) begin
            dfr <= 1'b1;
        end else begin
            dfr <= 1'b0;
        end

        prev_level <= current_level;

        case (current_level)
            LEVEL_ABOVE_S3: begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
            end
            LEVEL_BETWEEN_S3_S2: begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b1;
            end
            LEVEL_BETWEEN_S2_S1: begin
                fr3 <= 1'b0;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
            end
            LEVEL_BELOW_S1: begin
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
            end
        endcase
    end
end

endmodule
