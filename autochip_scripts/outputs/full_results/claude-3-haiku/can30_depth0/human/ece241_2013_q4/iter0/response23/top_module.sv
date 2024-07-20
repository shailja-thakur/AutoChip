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
parameter [1:0] 
    LEVEL_LOW = 2'b00,
    LEVEL_MID = 2'b01, 
    LEVEL_HIGH = 2'b10;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= LEVEL_LOW;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end
    else begin
        case (state)
            LEVEL_LOW: begin
                if (s[1] == 1'b1) begin
                    state <= LEVEL_MID;
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end
                else begin
                    state <= LEVEL_LOW;
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b1;
                end
            end
            LEVEL_MID: begin
                if (s[2] == 1'b1) begin
                    state <= LEVEL_HIGH;
                    fr3 <= 1'b1;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end
                else if (s[1] == 1'b0) begin
                    state <= LEVEL_LOW;
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b1;
                end
                else begin
                    state <= LEVEL_MID;
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end
            end
            LEVEL_HIGH: begin
                if (s[3] == 1'b1) begin
                    state <= LEVEL_HIGH;
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end
                else if (s[2] == 1'b0) begin
                    state <= LEVEL_MID;
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end
                else begin
                    state <= LEVEL_HIGH;
                    fr3 <= 1'b1;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end
            end
            default: begin
                state <= LEVEL_LOW;
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
            end
        endcase
    end
end

endmodule
