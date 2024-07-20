module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

localparam LEVEL_HIGH = 3'b111, // Sensors s[3], s[2], s[1] asserted
           LEVEL_MID_HIGH = 3'b110, // Sensors s[3], s[2] asserted
           LEVEL_MID_LOW = 3'b010, // Sensor s[1] asserted
           LEVEL_LOW = 3'b000; // No sensors asserted

reg [2:0] current_level, next_level;

always @(posedge clk) begin
    if (reset) begin
        current_level <= LEVEL_LOW;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end
    else begin
        current_level <= next_level;
    end
end

always @(*) begin
    next_level = current_level;
    case (s)
        LEVEL_HIGH: next_level = LEVEL_HIGH;
        LEVEL_MID_HIGH: next_level = LEVEL_MID_HIGH;
        LEVEL_MID_LOW: next_level = LEVEL_MID_LOW;
        LEVEL_LOW: next_level = LEVEL_LOW;
        default: next_level = current_level;
    endcase

    // Set output flow rates based on current water level
    case (current_level)
        LEVEL_HIGH: begin
            fr3 = 1'b0;
            fr2 = 1'b0;
            fr1 = 1'b0;
            dfr = 1'b0;
        end
        LEVEL_MID_HIGH: begin
            fr3 = 1'b0;
            fr2 = 1'b0;
            fr1 = 1'b1;
            dfr = 1'b0;
        end
        LEVEL_MID_LOW: begin
            fr3 = 1'b0;
            fr2 = 1'b1;
            fr1 = 1'b1;
            dfr = 1'b0;
        end
        LEVEL_LOW: begin
            fr3 = 1'b1;
            fr2 = 1'b1;
            fr1 = 1'b1;
            dfr = 1'b1;
        end
        default: begin
            fr3 = 1'b0;
            fr2 = 1'b0;
            fr1 = 1'b0;
            dfr = 1'b0;
        end
    endcase
end

endmodule
