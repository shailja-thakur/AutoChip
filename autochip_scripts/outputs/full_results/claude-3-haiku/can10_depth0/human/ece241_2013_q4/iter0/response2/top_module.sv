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
parameter ABOVE_S3 = 2'b00, BETWEEN_S3_S2 = 2'b01, BETWEEN_S2_S1 = 2'b10, BELOW_S1 = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= BELOW_S1;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        ABOVE_S3: begin
            fr3 <= 1'b0;
            fr2 <= 1'b0;
            fr1 <= 1'b0;
            dfr <= 1'b0;
            if (s == 3'b111) next_state = ABOVE_S3;
            else if (s == 3'b110) next_state = BETWEEN_S3_S2;
            else if (s == 3'b100) next_state = BETWEEN_S2_S1;
            else next_state = BELOW_S1;
        end
        BETWEEN_S3_S2: begin
            fr3 <= 1'b0;
            fr2 <= 1'b0;
            fr1 <= 1'b1;
            dfr <= 1'b0;
            if (s == 3'b111) next_state = ABOVE_S3;
            else if (s == 3'b110) next_state = BETWEEN_S3_S2;
            else if (s == 3'b100) next_state = BETWEEN_S2_S1;
            else next_state = BELOW_S1;
        end
        BETWEEN_S2_S1: begin
            fr3 <= 1'b0;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b0;
            if (s == 3'b111) next_state = ABOVE_S3;
            else if (s == 3'b110) next_state = BETWEEN_S3_S2;
            else if (s == 3'b100) next_state = BETWEEN_S2_S1;
            else next_state = BELOW_S1;
        end
        BELOW_S1: begin
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b1;
            if (s == 3'b111) next_state = ABOVE_S3;
            else if (s == 3'b110) next_state = BETWEEN_S3_S2;
            else if (s == 3'b100) next_state = BETWEEN_S2_S1;
            else next_state = BELOW_S1;
        end
    endcase
end

endmodule
