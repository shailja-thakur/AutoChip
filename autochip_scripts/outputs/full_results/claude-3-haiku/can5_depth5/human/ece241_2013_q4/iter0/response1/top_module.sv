module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [1:0] current_state;
reg [1:0] next_state;
parameter ABOVE_S3 = 2'b00,
          BETWEEN_S3_S2 = 2'b01,
          BETWEEN_S2_S1 = 2'b10,
          BELOW_S1 = 2'b11;

always @(posedge clk or posedge reset) begin
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
            if (s[3]) begin
                fr3 = 0;
                fr2 = 0;
                fr1 = 0;
                dfr = 0;
            end
            else begin
                next_state = BETWEEN_S3_S2;
            end
        end
        BETWEEN_S3_S2: begin
            fr3 = 0;
            fr2 = 1;
            fr1 = 1;
            dfr = 0;
            if (!s[2]) begin
                next_state = BETWEEN_S2_S1;
            end
            else if (!s[3]) begin
                next_state = BELOW_S1;
            end
        end
        BETWEEN_S2_S1: begin
            fr3 = 0;
            fr2 = 1;
            fr1 = 1;
            dfr = 1;
            if (!s[1]) begin
                next_state = BELOW_S1;
            end
            else if (s[2]) begin
                next_state = BETWEEN_S3_S2;
            end
        end
        BELOW_S1: begin
            fr3 = 1;
            fr2 = 1;
            fr1 = 1;
            dfr = 1;
            if (s[1]) begin
                next_state = BETWEEN_S2_S1;
            end
        end
    endcase
end
endmodule
