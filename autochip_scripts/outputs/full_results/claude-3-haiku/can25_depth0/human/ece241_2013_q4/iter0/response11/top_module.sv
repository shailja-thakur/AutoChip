module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

localparam ABOVE_S3 = 3'b111,
           BETWEEN_S3_S2 = 3'b110,
           BETWEEN_S2_S1 = 3'b100,
           BELOW_S1 = 3'b000;

reg [2:0] state, next_state;
reg prev_level_lower;

always @(posedge clk) begin
    if (reset) begin
        state <= BELOW_S1;
        prev_level_lower <= 1'b0;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end
    else begin
        state <= next_state;
        prev_level_lower <= (state > next_state);
    end
end

always @(*) begin
    next_state = state;
    case (state)
        ABOVE_S3: begin
            fr3 = 1'b0;
            fr2 = 1'b0;
            fr1 = 1'b0;
            dfr = 1'b0;
            if (s == 3'b000) next_state = BELOW_S1;
            else if (s == 3'b010) next_state = BETWEEN_S2_S1;
            else if (s == 3'b100) next_state = BETWEEN_S3_S2;
        end
        BETWEEN_S3_S2: begin
            fr3 = 1'b0;
            fr2 = 1'b0;
            fr1 = 1'b1;
            dfr = prev_level_lower ? 1'b1 : 1'b0;
            if (s == 3'b000) next_state = BELOW_S1;
            else if (s == 3'b010) next_state = BETWEEN_S2_S1;
            else if (s == 3'b111) next_state = ABOVE_S3;
        end
        BETWEEN_S2_S1: begin
            fr3 = 1'b0;
            fr2 = 1'b1;
            fr1 = 1'b1;
            dfr = prev_level_lower ? 1'b1 : 1'b0;
            if (s == 3'b000) next_state = BELOW_S1;
            else if (s == 3'b100) next_state = BETWEEN_S3_S2;
            else if (s == 3'b110) next_state = ABOVE_S3;
        end
        BELOW_S1: begin
            fr3 = 1'b1;
            fr2 = 1'b1;
            fr1 = 1'b1;
            dfr = 1'b1;
            if (s == 3'b010) next_state = BETWEEN_S2_S1;
            else if (s == 3'b100) next_state = BETWEEN_S3_S2;
            else if (s == 3'b110) next_state = ABOVE_S3;
        end
    endcase
end
endmodule
