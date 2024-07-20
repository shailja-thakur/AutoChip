module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

localparam ABOVE_S3 = 3'b111;
localparam BETWEEN_S3_S2 = 3'b110;
localparam BETWEEN_S2_S1 = 3'b100;
localparam BELOW_S1 = 3'b000;

reg [2:0] current_state, next_state;
reg [2:0] prev_state;

always @(posedge clk) begin
    if (reset) begin
        current_state <= BELOW_S1;
        prev_state <= BELOW_S1;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end
    else begin
        current_state <= next_state;
        prev_state <= current_state;
    end
end

always @(*) begin
    case (current_state)
        ABOVE_S3: begin
            fr3 = 1'b0;
            fr2 = 1'b0;
            fr1 = 1'b0;
            dfr = 1'b0;
        end
        BETWEEN_S3_S2: begin
            fr3 = 1'b0;
            fr2 = 1'b0;
            fr1 = 1'b1;
            dfr = (prev_state < current_state) ? 1'b1 : 1'b0;
        end
        BETWEEN_S2_S1: begin
            fr3 = 1'b0;
            fr2 = 1'b1;
            fr1 = 1'b1;
            dfr = (prev_state < current_state) ? 1'b1 : 1'b0;
        end
        BELOW_S1: begin
            fr3 = 1'b1;
            fr2 = 1'b1;
            fr1 = 1'b1;
            dfr = 1'b1;
        end
        default: begin
            fr3 = 1'b1;
            fr2 = 1'b1;
            fr1 = 1'b1;
            dfr = 1'b1;
        end
    endcase
end

always @(*) begin
    case (current_state)
        ABOVE_S3: next_state = (s == 3'b111) ? ABOVE_S3 : ((s == 3'b110) ? BETWEEN_S3_S2 : ((s == 3'b100) ? BETWEEN_S2_S1 : BELOW_S1));
        BETWEEN_S3_S2: next_state = (s == 3'b111) ? ABOVE_S3 : ((s == 3'b110) ? BETWEEN_S3_S2 : ((s == 3'b100) ? BETWEEN_S2_S1 : BELOW_S1));
        BETWEEN_S2_S1: next_state = (s == 3'b111) ? ABOVE_S3 : ((s == 3'b110) ? BETWEEN_S3_S2 : ((s == 3'b100) ? BETWEEN_S2_S1 : BELOW_S1));
        BELOW_S1: next_state = (s == 3'b111) ? ABOVE_S3 : ((s == 3'b110) ? BETWEEN_S3_S2 : ((s == 3'b100) ? BETWEEN_S2_S1 : BELOW_S1));
        default: next_state = BELOW_S1;
    endcase
end

endmodule
