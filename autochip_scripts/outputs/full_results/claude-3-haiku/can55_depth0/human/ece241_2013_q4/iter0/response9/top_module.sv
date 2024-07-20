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

always @(posedge clk) begin
    if (reset) begin
        current_state <= BELOW_S1;
        fr3 <= 1;
        fr2 <= 1;
        fr1 <= 1;
        dfr <= 1;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    next_state = current_state;
    case (current_state)
        ABOVE_S3: begin
            fr3 = 0;
            fr2 = 0;
            fr1 = 0;
            dfr = 0;
            if (s[3]) next_state = ABOVE_S3;
            else if (s[2]) next_state = BETWEEN_S3_S2;
            else if (s[1]) next_state = BETWEEN_S2_S1;
            else next_state = BELOW_S1;
        end
        BETWEEN_S3_S2: begin
            fr3 = 0;
            fr2 = 0;
            fr1 = 1;
            dfr = 0;
            if (s[3]) next_state = ABOVE_S3;
            else if (s[2]) next_state = BETWEEN_S3_S2;
            else if (s[1]) next_state = BETWEEN_S2_S1;
            else next_state = BELOW_S1;
        end
        BETWEEN_S2_S1: begin
            fr3 = 0;
            fr2 = 1;
            fr1 = 1;
            dfr = 0;
            if (s[3]) next_state = ABOVE_S3;
            else if (s[2]) next_state = BETWEEN_S3_S2;
            else if (s[1]) next_state = BETWEEN_S2_S1;
            else next_state = BELOW_S1;
        end
        BELOW_S1: begin
            fr3 = 1;
            fr2 = 1;
            fr1 = 1;
            dfr = 1;
            if (s[3]) next_state = ABOVE_S3;
            else if (s[2]) next_state = BETWEEN_S3_S2;
            else if (s[1]) next_state = BETWEEN_S2_S1;
            else next_state = BELOW_S1;
        end
    endcase
end

endmodule
