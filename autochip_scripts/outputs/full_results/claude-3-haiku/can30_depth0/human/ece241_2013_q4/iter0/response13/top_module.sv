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
parameter LEVEL_HIGH = 2'b11, LEVEL_MID = 2'b10, LEVEL_LOW = 2'b01, LEVEL_EMPTY = 2'b00;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= LEVEL_EMPTY;
        fr3 <= 1;
        fr2 <= 1;
        fr1 <= 1;
        dfr <= 1;
    end
    else begin
        case (s)
            3'b111: state <= LEVEL_HIGH;
            3'b110: state <= LEVEL_MID;
            3'b100: state <= LEVEL_LOW;
            3'b000: state <= LEVEL_EMPTY;
            default: state <= state;
        endcase

        case (state)
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
                dfr <= 1;
            end
            LEVEL_EMPTY: begin
                fr3 <= 1;
                fr2 <= 1;
                fr1 <= 1;
                dfr <= 1;
            end
            default: begin
                fr3 <= 1;
                fr2 <= 1;
                fr1 <= 1;
                dfr <= 1;
            end
        endcase
    end
end

endmodule
