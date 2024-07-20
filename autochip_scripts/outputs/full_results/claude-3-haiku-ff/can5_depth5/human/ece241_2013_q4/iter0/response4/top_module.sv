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
reg prev_state;

localparam LEVEL_ABOVE_S3 = 2'b00;
localparam LEVEL_BETWEEN_S3_S2 = 2'b01;
localparam LEVEL_BETWEEN_S2_S1 = 2'b10;
localparam LEVEL_BELOW_S1 = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= LEVEL_BELOW_S1;
        prev_state <= 1'b0;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end
    else begin
        prev_state <= state;
        case (s)
            3'b111: state <= LEVEL_ABOVE_S3;
            3'b011: state <= LEVEL_BETWEEN_S3_S2;
            3'b001: state <= LEVEL_BETWEEN_S2_S1;
            3'b000: state <= LEVEL_BELOW_S1;
            default: state <= state;
        endcase

        case (state)
            LEVEL_ABOVE_S3: begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
            end
            LEVEL_BETWEEN_S3_S2: begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b1;
                dfr <= (prev_state == LEVEL_BELOW_S1) ? 1'b1 : 1'b0;
            end
            LEVEL_BETWEEN_S2_S1: begin
                fr3 <= 1'b0;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= (prev_state == LEVEL_BELOW_S1) ? 1'b1 : 1'b0;
            end
            LEVEL_BELOW_S1: begin
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
            end
            default: begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
            end
        endcase
    end
end

endmodule
