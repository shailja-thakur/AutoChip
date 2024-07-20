module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

localparam STATE_ABOVE_S3 = 2'b00;
localparam STATE_BETWEEN_S3_S2 = 2'b01;
localparam STATE_BETWEEN_S2_S1 = 2'b10;
localparam STATE_BELOW_S1 = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_BELOW_S1;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end else begin
        state <= next_state;
        case (state)
            STATE_ABOVE_S3: begin
                if (s[3]) begin
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end else if (s[2]) begin
                    fr3 <= 1'b0;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                end else if (s[1]) begin
                    fr3 <= 1'b0;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b1;
                end else begin
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b1;
                end
            end
            STATE_BETWEEN_S3_S2: begin
                if (s[3]) begin
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end else if (s[2]) begin
                    fr3 <= 1'b0;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                end else if (s[1]) begin
                    fr3 <= 1'b0;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b1;
                end else begin
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b1;
                end
            end
            STATE_BETWEEN_S2_S1: begin
                if (s[3]) begin
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end else if (s[2]) begin
                    fr3 <= 1'b0;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                end else if (s[1]) begin
                    fr3 <= 1'b0;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b1;
                end else begin
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b1;
                end
            end
            STATE_BELOW_S1: begin
                if (s[3]) begin
                    fr3 <= 1'b1;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end else if (s[2]) begin
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b1;
                end else if (s[1]) begin
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b1;
                end else begin
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b1;
                end
            end
        endcase
    end
end

always @(*) begin
    case (state)
        STATE_ABOVE_S3: next_state = s[3] ? STATE_ABOVE_S3 : (s[2] ? STATE_BETWEEN_S3_S2 : (s[1] ? STATE_BETWEEN_S2_S1 : STATE_BELOW_S1));
        STATE_BETWEEN_S3_S2: next_state = s[3] ? STATE_ABOVE_S3 : (s[2] ? STATE_BETWEEN_S3_S2 : (s[1] ? STATE_BETWEEN_S2_S1 : STATE_BELOW_S1));
        STATE_BETWEEN_S2_S1: next_state = s[3] ? STATE_ABOVE_S3 : (s[2] ? STATE_BETWEEN_S3_S2 : (s[1] ? STATE_BETWEEN_S2_S1 : STATE_BELOW_S1));
        STATE_BELOW_S1: next_state = s[3] ? STATE_ABOVE_S3 : (s[2] ? STATE_BETWEEN_S3_S2 : (s[1] ? STATE_BETWEEN_S2_S1 : STATE_BELOW_S1));
    endcase
end

endmodule
