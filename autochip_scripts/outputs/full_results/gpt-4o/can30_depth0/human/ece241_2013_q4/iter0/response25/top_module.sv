module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    typedef enum logic [1:0] {
        LOW = 2'b00,
        BELOW_MID = 2'b01,
        ABOVE_MID = 2'b10,
        HIGH = 2'b11
    } water_level_t;

    water_level_t level;
    water_level_t prev_level;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            level <= LOW;
            prev_level <= LOW;
            fr3 <= 1;
            fr2 <= 1;
            fr1 <= 1;
            dfr <= 1;
        end else begin
            prev_level <= level;
            case (s)
                3'b000: level <= LOW;
                3'b001: level <= BELOW_MID;
                3'b011: level <= ABOVE_MID;
                3'b111: level <= HIGH;
                default: level <= LOW;
            endcase
            
            case (level)
                LOW: begin
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
                BELOW_MID: begin
                    fr3 <= 0;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= (prev_level == LOW) ? 1 : 0;
                end
                ABOVE_MID: begin
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 1;
                    dfr <= (prev_level == BELOW_MID) ? 1 : 0;
                end
                HIGH: begin
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 0;
                    dfr <= 0;
                end
            endcase
        end
    end

endmodule
