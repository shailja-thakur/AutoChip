module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

localparam ABOVE_S3 = 2'b11,
           BETWEEN_S3_S2 = 2'b10,
           BETWEEN_S2_S1 = 2'b01,
           BELOW_S1 = 2'b00;

reg [1:0] current_state, next_state;
reg [1:0] prev_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= BELOW_S1;
        prev_state <= BELOW_S1;
        fr3 <= 1;
        fr2 <= 1;
        fr1 <= 1;
        dfr <= 1;
    end
    else begin
        current_state <= next_state;
        prev_state <= current_state;
    end
end

always @(*) begin
    next_state = current_state;
    case (current_state)
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
            end
            else if (s[1]) begin
                next_state = BETWEEN_S2_S1;
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
            end
            else if (s[1]) begin
                next_state = BETWEEN_S2_S1;
            end
            else begin
                next_state = BELOW_S1;
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
            end
        end
    endcase
end

always @(*) begin
    fr3 = 0;
    fr2 = 0;
    fr1 = 0;
    dfr = 0;
    case (next_state)
        ABOVE_S3: begin
            // No flow
        end
        BETWEEN_S3_S2: begin
            fr1 = 1;
        end
        BETWEEN_S2_S1: begin
            fr1 = 1;
            fr2 = 1;
        end
        BELOW_S1: begin
            fr1 = 1;
            fr2 = 1;
            fr3 = 1;
            if (prev_state < next_state) begin
                dfr = 1;
            end
        end
    endcase
end

endmodule
