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

parameter STATE_ABOVE_S3 = 2'b00;
parameter STATE_BETWEEN_S3_S2 = 2'b01;
parameter STATE_BETWEEN_S2_S1 = 2'b10;
parameter STATE_BELOW_S1 = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        current_state <= STATE_BELOW_S1;
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
    next_state = current_state;
    case (current_state)
        STATE_ABOVE_S3: begin
            if (s[3]) begin
                fr3 = 1'b0;
                fr2 = 1'b0;
                fr1 = 1'b0;
                dfr = 1'b0;
            end
            else begin
                next_state = STATE_BETWEEN_S3_S2;
            end
        end
        STATE_BETWEEN_S3_S2: begin
            if (s[2] && s[1]) begin
                fr3 = 1'b0;
                fr2 = 1'b1;
                fr1 = 1'b1;
                dfr = 1'b0;
            end
            else if (~s[2] && s[1]) begin
                next_state = STATE_BETWEEN_S2_S1;
            end
            else if (~s[1]) begin
                next_state = STATE_BELOW_S1;
            end
        end
        STATE_BETWEEN_S2_S1: begin
            if (s[1]) begin
                fr3 = 1'b0;
                fr2 = 1'b1;
                fr1 = 1'b1;
                dfr = 1'b1;
            end
            else begin
                next_state = STATE_BELOW_S1;
            end
        end
        STATE_BELOW_S1: begin
            fr3 = 1'b1;
            fr2 = 1'b1;
            fr1 = 1'b1;
            dfr = 1'b1;
            if (s[1] || s[2] || s[3]) begin
                next_state = STATE_BETWEEN_S2_S1;
            end
        end
    endcase
end

endmodule
