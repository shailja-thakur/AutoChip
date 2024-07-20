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

reg [2:0] curr_level, prev_level;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        curr_level <= LEVEL_BELOW_S1;
        prev_level <= LEVEL_BELOW_S1;
        fr3 <= 1;
        fr2 <= 1;
        fr1 <= 1;
        dfr <= 1;
    end
    else begin
        prev_level <= curr_level;
        case (s)
            3'b111: curr_level <= LEVEL_ABOVE_S3;
            3'b110: curr_level <= LEVEL_BETWEEN_S3_S2;
            3'b100: curr_level <= LEVEL_BETWEEN_S2_S1;
            3'b000: curr_level <= LEVEL_BELOW_S1;
            default: curr_level <= curr_level;
        endcase

        case (curr_level)
            LEVEL_ABOVE_S3: begin
                fr3 <= 0;
                fr2 <= 0;
                fr1 <= 0;
                dfr <= 0;
            end
            LEVEL_BETWEEN_S3_S2: begin
                fr3 <= 1;
                fr2 <= 0;
                fr1 <= 1;
                dfr <= prev_level < curr_level ? 1 : 0;
            end
            LEVEL_BETWEEN_S2_S1: begin
                fr3 <= 1;
                fr2 <= 1;
                fr1 <= 1;
                dfr <= prev_level < curr_level ? 1 : 0;
            end
            LEVEL_BELOW_S1: begin
                fr3 <= 1;
                fr2 <= 1;
                fr1 <= 1;
                dfr <= 1;
            end
            default: begin
                fr3 <= 1;
                fr2 <= 1;
                fr1 <= 1;
                dfr <= 0;
            end
        endcase
    end
end

endmodule
