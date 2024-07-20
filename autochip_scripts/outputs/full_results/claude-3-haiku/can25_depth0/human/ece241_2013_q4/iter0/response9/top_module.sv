module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [1:0] state, next_state;
parameter ABOVE_S3 = 2'b00, BETWEEN_S3_S2 = 2'b01, BETWEEN_S2_S1 = 2'b10, BELOW_S1 = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= BELOW_S1;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    fr3 = 1'b0;
    fr2 = 1'b0;
    fr1 = 1'b0;
    dfr = 1'b0;

    case (state)
        ABOVE_S3: begin
            if (s[3]) begin
                next_state = ABOVE_S3;
            end
            else if (s[2]) begin
                next_state = BETWEEN_S3_S2;
            end
            else if (s[1]) begin
                next_state = BETWEEN_S2_S1;
            end
            else begin
                next_state = BELOW_S1;
            end
        end

        BETWEEN_S3_S2: begin
            if (s[3]) begin
                next_state = ABOVE_S3;
            end
            else if (s[2]) begin
                next_state = BETWEEN_S3_S2;
                fr1 = 1'b1;
            end
            else if (s[1]) begin
                next_state = BETWEEN_S2_S1;
                fr1 = 1'b1;
            end
            else begin
                next_state = BELOW_S1;
            end
        end

        BETWEEN_S2_S1: begin
            if (s[3]) begin
                next_state = ABOVE_S3;
            end
            else if (s[2]) begin
                next_state = BETWEEN_S3_S2;
                fr1 = 1'b1;
                fr2 = 1'b1;
            end
            else if (s[1]) begin
                next_state = BETWEEN_S2_S1;
                fr1 = 1'b1;
                fr2 = 1'b1;
            end
            else begin
                next_state = BELOW_S1;
                fr1 = 1'b1;
                fr2 = 1'b1;
                dfr = 1'b1;
            end
        end

        BELOW_S1: begin
            if (s[3]) begin
                next_state = ABOVE_S3;
            end
            else if (s[2]) begin
                next_state = BETWEEN_S3_S2;
            end
            else if (s[1]) begin
                next_state = BETWEEN_S2_S1;
            end
            else begin
                next_state = BELOW_S1;
                fr1 = 1'b1;
                fr2 = 1'b1;
                fr3 = 1'b1;
                dfr = 1'b1;
            end
        end
    endcase
end
endmodule
