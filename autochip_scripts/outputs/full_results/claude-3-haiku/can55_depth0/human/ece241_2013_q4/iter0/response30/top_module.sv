module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

parameter LEVEL_HIGH = 3'b111,
          LEVEL_MEDIUM_HIGH = 3'b110,
          LEVEL_MEDIUM_LOW = 3'b100,
          LEVEL_LOW = 3'b000;

reg [2:0] water_level;
reg [2:0] prev_level;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        water_level <= LEVEL_LOW;
        prev_level <= LEVEL_LOW;
        fr3 <= 1;
        fr2 <= 1;
        fr1 <= 1;
        dfr <= 1;
    end
    else begin
        // Update water level
        if (s[3]) begin
            water_level <= LEVEL_HIGH;
        end
        else if (s[2]) begin
            water_level <= LEVEL_MEDIUM_HIGH;
        end
        else if (s[1]) begin
            water_level <= LEVEL_MEDIUM_LOW;
        end
        else begin
            water_level <= LEVEL_LOW;
        end

        // Update flow rates
        case (water_level)
            LEVEL_HIGH: begin
                fr3 <= 0;
                fr2 <= 0;
                fr1 <= 0;
                dfr <= 0;
            end
            LEVEL_MEDIUM_HIGH: begin
                fr3 <= 0;
                fr2 <= 0;
                fr1 <= 1;
                dfr <= (water_level > prev_level) ? 1 : 0;
            end
            LEVEL_MEDIUM_LOW: begin
                fr3 <= 0;
                fr2 <= 1;
                fr1 <= 1;
                dfr <= (water_level > prev_level) ? 1 : 0;
            end
            LEVEL_LOW: begin
                fr3 <= 1;
                fr2 <= 1;
                fr1 <= 1;
                dfr <= (water_level > prev_level) ? 1 : 0;
            end
        endcase

        // Update previous level
        prev_level <= water_level;
    end
end

endmodule
