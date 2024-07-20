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
parameter LEVEL_HIGH = 2'b11,
          LEVEL_MID  = 2'b10,
          LEVEL_LOW  = 2'b01,
          LEVEL_EMPTY = 2'b00;

always @(posedge clk) begin
    if (reset) begin
        state <= LEVEL_EMPTY;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end
    else begin
        case (state)
            LEVEL_HIGH: begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
                if (~s[3]) begin
                    state <= LEVEL_MID;
                end
            end
            LEVEL_MID: begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b1;
                dfr <= 1'b0;
                if (~s[2]) begin
                    state <= LEVEL_LOW;
                end
                else if (s[3]) begin
                    state <= LEVEL_HIGH;
                end
            end
            LEVEL_LOW: begin
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
                if (~s[1]) begin
                    state <= LEVEL_EMPTY;
                end
                else if (s[2]) begin
                    state <= LEVEL_MID;
                end
            end
            LEVEL_EMPTY: begin
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
                if (s[1]) begin
                    state <= LEVEL_LOW;
                end
            end
            default: state <= LEVEL_EMPTY;
        endcase
    end
end

endmodule
