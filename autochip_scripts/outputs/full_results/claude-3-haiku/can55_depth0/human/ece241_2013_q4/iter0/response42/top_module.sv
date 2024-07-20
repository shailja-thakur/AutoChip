module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [2:0] state;
parameter ABOVE_S3 = 3'd0, BETWEEN_S3_S2 = 3'd1, BETWEEN_S2_S1 = 3'd2, BELOW_S1 = 3'd3;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= BELOW_S1;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end
    else begin
        case (state)
            ABOVE_S3: begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
            end
            BETWEEN_S3_S2: begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b1;
                dfr <= 1'b0;
            end
            BETWEEN_S2_S1: begin
                fr3 <= 1'b0;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b0;
            end
            BELOW_S1: begin
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
            end
            default: begin
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
            end
        endcase

        if (s == 3'b111) begin
            state <= ABOVE_S3;
        end
        else if (s == 3'b110) begin
            state <= BETWEEN_S3_S2;
        end
        else if (s == 3'b100) begin
            state <= BETWEEN_S2_S1;
        end
        else begin
            state <= BELOW_S1;
        end
    end
end

endmodule
