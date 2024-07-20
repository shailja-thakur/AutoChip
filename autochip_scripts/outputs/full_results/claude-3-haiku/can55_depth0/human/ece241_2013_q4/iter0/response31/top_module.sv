module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

parameter LEVEL_HIGH = 3'b111;
parameter LEVEL_MID  = 3'b011;
parameter LEVEL_LOW  = 3'b001;
parameter LEVEL_NONE = 3'b000;

reg [2:0] current_level;
reg [2:0] prev_level;

always @(posedge clk) begin
    if (reset) begin
        current_level <= LEVEL_NONE;
        prev_level <= LEVEL_NONE;
        fr3 <= 1;
        fr2 <= 1;
        fr1 <= 1;
        dfr <= 0;
    end
    else begin
        // Update current water level
        if (s[3]) begin
            current_level <= LEVEL_HIGH;
        end
        else if (s[2]) begin
            current_level <= LEVEL_MID;
        end
        else if (s[1]) begin
            current_level <= LEVEL_LOW;
        end
        else begin
            current_level <= LEVEL_NONE;
        end

        // Update previous water level
        prev_level <= current_level;

        // Determine flow rates
        case (current_level)
            LEVEL_HIGH: begin
                fr3 <= 0;
                fr2 <= 0;
                fr1 <= 0;
                dfr <= 0;
            end
            LEVEL_MID: begin
                fr3 <= 0;
                fr2 <= 0;
                fr1 <= 1;
                dfr <= 0;
            end
            LEVEL_LOW: begin
                fr3 <= 0;
                fr2 <= 1;
                fr1 <= 1;
                dfr <= (prev_level < current_level) ? 1 : 0;
            end
            LEVEL_NONE: begin
                fr3 <= 1;
                fr2 <= 1;
                fr1 <= 1;
                dfr <= 1;
            end
        endcase
    end
end

endmodule
