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
reg [2:0] prev_state;

parameter ABOVE_S3 = 3'b111;
parameter BETWEEN_S3_S2 = 3'b110;
parameter BETWEEN_S2_S1 = 3'b100;
parameter BELOW_S1 = 3'b000;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= BELOW_S1;
    end else begin
        prev_state <= state;
        case (prev_state)
            ABOVE_S3: begin
                if (s == ABOVE_S3) begin
                    state <= ABOVE_S3;
                end else if (s[2:1] == BETWEEN_S3_S2) begin
                    state <= BETWEEN_S3_S2;
                end else if (s[1] == BETWEEN_S2_S1) begin
                    state <= BETWEEN_S2_S1;
                end else if (s == BELOW_S1) begin
                    state <= BELOW_S1;
                end
            end
            BETWEEN_S3_S2: begin
                if (s == ABOVE_S3) begin
                    state <= ABOVE_S3;
                end else if (s[2:1] == BETWEEN_S3_S2) begin
                    state <= BETWEEN_S3_S2;
                end else if (s[1] == BETWEEN_S2_S1) begin
                    state <= BETWEEN_S2_S1;
                end else if (s == BELOW_S1) begin
                    state <= BELOW_S1;
                end
            end
            BETWEEN_S2_S1: begin
                if (s == ABOVE_S3) begin
                    state <= ABOVE_S3;
                end else if (s[2] == BETWEEN_S3_S2) begin
                    state <= BETWEEN_S3_S2;
                end else if (s[1] == BETWEEN_S2_S1) begin
                    state <= BETWEEN_S2_S1;
                end else if (s == BELOW_S1) begin
                    state <= BELOW_S1;
                end
            end
            BELOW_S1: begin
                if (s == ABOVE_S3) begin
                    state <= ABOVE_S3;
                end else if (s[2:1] == BETWEEN_S3_S2) begin
                    state <= BETWEEN_S3_S2;
                end else if (s[1] == BETWEEN_S2_S1) begin
                    state <= BETWEEN_S2_S1;
                end else if (s == BELOW_S1) begin
                    state <= BELOW_S1;
                end
            end
        endcase
    end
end

always @(state) begin
    case (state)
        ABOVE_S3: begin
            fr3 <= 0;
            fr2 <= 0;
            fr1 <= 0;
            dfr <= 0;
        end
        BETWEEN_S3_S2: begin
            fr3 <= 0;
            fr2 <= 0;
            fr1 <= 1;
            dfr <= 0;
        end
        BETWEEN_S2_S1: begin
            fr3 <= 0;
            fr2 <= 1;
            fr1 <= 1;
            dfr <= 0;
        end
        BELOW_S1: begin
            fr3 <= 1;
            fr2 <= 1;
            fr1 <= 1;
            dfr <= 0;
        end
    endcase
end

endmodule
