module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [1:0] current_state, next_state;
parameter LEVEL_ABOVE_S3 = 2'b00,
          LEVEL_BETWEEN_S3_S2 = 2'b01,
          LEVEL_BETWEEN_S2_S1 = 2'b10,
          LEVEL_BELOW_S1 = 2'b11;

always @(*) begin
    case (s)
        3'b111: next_state = LEVEL_ABOVE_S3;
        3'b110: next_state = LEVEL_BETWEEN_S3_S2;
        3'b100: next_state = LEVEL_BETWEEN_S2_S1;
        3'b000: next_state = LEVEL_BELOW_S1;
        default: next_state = current_state;
    endcase
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= LEVEL_BELOW_S1;
        fr3 <= 1;
        fr2 <= 1;
        fr1 <= 1;
        dfr <= 1;
    end
    else begin
        current_state <= next_state;
        case (current_state)
            LEVEL_ABOVE_S3: begin
                fr3 <= 0;
                fr2 <= 0;
                fr1 <= 0;
                dfr <= 0;
            end
            LEVEL_BETWEEN_S3_S2: begin
                fr3 <= 0;
                fr2 <= 1;
                fr1 <= 1;
                dfr <= 0;
            end
            LEVEL_BETWEEN_S2_S1: begin
                fr3 <= 0;
                fr2 <= 1;
                fr1 <= 1;
                dfr <= 1;
            end
            LEVEL_BELOW_S1: begin
                fr3 <= 1;
                fr2 <= 1;
                fr1 <= 1;
                dfr <= 1;
            end
        endcase
    end
end

endmodule
