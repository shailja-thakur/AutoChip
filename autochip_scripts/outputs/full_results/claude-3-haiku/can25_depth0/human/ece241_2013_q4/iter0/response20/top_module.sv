module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

localparam ABOVE_S3 = 3'b111;
localparam BETWEEN_S3_S2 = 3'b110;
localparam BETWEEN_S2_S1 = 3'b100;
localparam BELOW_S1 = 3'b000;

reg [2:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= BELOW_S1;
        fr3 <= 1;
        fr2 <= 1;
        fr1 <= 1;
        dfr <= 1;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        ABOVE_S3: begin
            fr3 <= 0;
            fr2 <= 0;
            fr1 <= 0;
            dfr <= 0;
            if (~s[3]) begin
                next_state = BETWEEN_S3_S2;
            end
        end
        BETWEEN_S3_S2: begin
            fr3 <= 1;
            fr2 <= 0;
            fr1 <= 1;
            dfr <= 0;
            if (s[1]) begin
                next_state = BETWEEN_S2_S1;
            end
            else if (~s[2]) begin
                next_state = BELOW_S1;
            end
        end
        BETWEEN_S2_S1: begin
            fr3 <= 1;
            fr2 <= 1;
            fr1 <= 1;
            dfr <= 1;
            if (~s[1]) begin
                next_state = BELOW_S1;
            end
        end
        BELOW_S1: begin
            fr3 <= 1;
            fr2 <= 1;
            fr1 <= 1;
            dfr <= 1;
            if (s[1]) begin
                next_state = BETWEEN_S2_S1;
            end
        end
    endcase
end

endmodule
