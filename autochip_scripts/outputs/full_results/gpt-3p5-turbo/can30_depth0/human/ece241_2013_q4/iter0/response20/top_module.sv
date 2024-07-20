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
reg [1:0] prev_state;

parameter ABOVE_S3 = 2'b00;
parameter BETWEEN_S3_S2 = 2'b01;
parameter BETWEEN_S2_S1 = 2'b10;
parameter BELOW_S1 = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= ABOVE_S3;
        prev_state <= ABOVE_S3;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end else begin
        case (s)
            3'b111: // Above s[3]
                state <= ABOVE_S3;
            3'b110: // Between s[3] and s[2]
                state <= BETWEEN_S3_S2;
            3'b100: // Between s[2] and s[1]
                state <= BETWEEN_S2_S1;
            3'b000: // Below s[1]
                state <= BELOW_S1;
        endcase
    end
end

always @(posedge clk) begin
    prev_state <= state;
    case (state)
        ABOVE_S3:
            begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
            end
        BETWEEN_S3_S2:
            begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b1;
                dfr <= 1'b0;
            end
        BETWEEN_S2_S1:
            begin
                fr3 <= 1'b0;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b0;
            end
        BELOW_S1:
            begin
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
            end
    endcase
end

endmodule
