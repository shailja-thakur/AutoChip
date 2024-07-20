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

parameter IDLE = 3'b000;
parameter ABOVE_S3 = 3'b001;
parameter BETWEEN_S3_S2 = 3'b010;
parameter BETWEEN_S2_S1 = 3'b011;
parameter BELOW_S1 = 3'b100;

always @ (posedge clk) begin
    if (reset) begin
        state <= IDLE;
        prev_state <= IDLE;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end else begin
        prev_state <= state;
        case (state)
            IDLE: begin
                if (s == 3'b000) begin
                    state <= BELOW_S1;
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end else if (s == 3'b001) begin
                    state <= BELOW_S1;
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                end else if (s == 3'b010) begin
                    state <= BETWEEN_S3_S2;
                    fr3 <= 1'b0;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                end else if (s == 3'b011) begin
                    state <= BETWEEN_S2_S1;
                    fr3 <= 1'b0;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= prev_state == BETWEEN_S3_S2 ? 1'b1 : 1'b0;
                end else if (s == 3'b100) begin
                    state <= ABOVE_S3;
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end
            end
            ABOVE_S3: begin
                if (s != 3'b111) begin
                    state <= IDLE;
                end
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
            end
            BETWEEN_S3_S2: begin
                if (s == 3'b111) begin
                    state <= ABOVE_S3;
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end else if (s == 3'b001) begin
                    state <= BETWEEN_S2_S1;
                    fr3 <= 1'b0;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= prev_state == BETWEEN_S2_S1 ? 1'b1 : 1'b0;
                end else if (s == 3'b010) begin
                    state <= BETWEEN_S3_S2;
                    fr3 <= 1'b0;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                end else if (s == 3'b100) begin
                    state <= BELOW_S1;
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                end
            end
            BETWEEN_S2_S1: begin
                if (s == 3'b111) begin
                    state <= ABOVE_S3;
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end else if (s == 3'b010) begin
                    state <= BETWEEN_S3_S2;
                    fr3 <= 1'b0;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                end else if (s == 3'b100) begin
                    state <= BELOW_S1;
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                end
            end
            BELOW_S1: begin
                if (s != 3'b000) begin
                    state <= IDLE;
                end
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
            end
        endcase
    end
end

endmodule
