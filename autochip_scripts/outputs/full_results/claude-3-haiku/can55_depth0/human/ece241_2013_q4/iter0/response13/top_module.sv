module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

localparam IDLE = 2'b00,
          BELOW_S1 = 2'b01, 
          BETWEEN_S1_S2 = 2'b10,
          BETWEEN_S2_S3 = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk or posedge reset) begin
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
    case (state)
        IDLE: begin
            if (~s[3] && ~s[2] && ~s[1]) begin
                next_state = BELOW_S1;
            end
            else if (s[3] && s[2] && s[1]) begin
                next_state = BETWEEN_S2_S3;
            end
            else if (s[2] && s[1] && ~s[3]) begin
                next_state = BETWEEN_S1_S2;
            end
        end
        BELOW_S1: begin
            fr3 = 1'b1;
            fr2 = 1'b1; 
            fr1 = 1'b1;
            dfr = 1'b1;
            if (s[1] || s[2] || s[3]) begin
                next_state = IDLE;
            end
        end
        BETWEEN_S1_S2: begin
            fr3 = 1'b0;
            fr2 = 1'b1;
            fr1 = 1'b1;
            dfr = 1'b0;
            if (~s[2]) begin
                next_state = BELOW_S1;
            end
            else if (s[3]) begin
                next_state = BETWEEN_S2_S3;
            end
        end
        BETWEEN_S2_S3: begin
            fr3 = 1'b0;
            fr2 = 1'b0;
            fr1 = 1'b1;
            dfr = 1'b0;
            if (~s[3]) begin
                next_state = BETWEEN_S1_S2;
            end
        end
    endcase
end

endmodule
