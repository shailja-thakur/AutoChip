module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

localparam S_ABOVE_S3 = 3'b111;
localparam S_BETWEEN_S3_S2 = 3'b110;
localparam S_BETWEEN_S2_S1 = 3'b100;
localparam S_BELOW_S1 = 3'b000;

reg [2:0] state, next_state;
reg prev_level_lower;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= S_BELOW_S1;
        prev_level_lower <= 1'b0;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b0;
    end
    else begin
        state <= next_state;
        prev_level_lower <= (state > next_state);
    end
end

always @(*) begin
    next_state = state;
    fr3 = 1'b0;
    fr2 = 1'b0;
    fr1 = 1'b0;
    dfr = 1'b0;

    case (state)
        S_ABOVE_S3: begin
            if (s[3:1] == 3'b111) begin
                next_state = S_ABOVE_S3;
            end
            else if (s[3:1] == 3'b110) begin
                next_state = S_BETWEEN_S3_S2;
            end
            else if (s[3:1] == 3'b100) begin
                next_state = S_BETWEEN_S2_S1;
            end
            else begin
                next_state = S_BELOW_S1;
            end
        end
        S_BETWEEN_S3_S2: begin
            fr1 = 1'b1;
            if (s[3:1] == 3'b111) begin
                next_state = S_ABOVE_S3;
            end
            else if (s[3:1] == 3'b110) begin
                next_state = S_BETWEEN_S3_S2;
            end
            else if (s[3:1] == 3'b100) begin
                next_state = S_BETWEEN_S2_S1;
            end
            else begin
                next_state = S_BELOW_S1;
            end
        end
        S_BETWEEN_S2_S1: begin
            fr1 = 1'b1;
            fr2 = 1'b1;
            if (s[3:1] == 3'b111) begin
                next_state = S_ABOVE_S3;
            end
            else if (s[3:1] == 3'b110) begin
                next_state = S_BETWEEN_S3_S2;
            end
            else if (s[3:1] == 3'b100) begin
                next_state = S_BETWEEN_S2_S1;
            end
            else begin
                next_state = S_BELOW_S1;
            end
        end
        S_BELOW_S1: begin
            fr1 = 1'b1;
            fr2 = 1'b1;
            fr3 = 1'b1;
            dfr = prev_level_lower;
            if (s[3:1] == 3'b111) begin
                next_state = S_ABOVE_S3;
            end
            else if (s[3:1] == 3'b110) begin
                next_state = S_BETWEEN_S3_S2;
            end
            else if (s[3:1] == 3'b100) begin
                next_state = S_BETWEEN_S2_S1;
            end
            else begin
                next_state = S_BELOW_S1;
            end
        end
    endcase
end

endmodule
