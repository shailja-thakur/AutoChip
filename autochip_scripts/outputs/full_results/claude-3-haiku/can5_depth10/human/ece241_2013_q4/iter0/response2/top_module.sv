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
parameter ABOVE_3 = 2'b00, BETWEEN_3_2 = 2'b01, BETWEEN_2_1 = 2'b10, BELOW_1 = 2'b11;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        current_state <= BELOW_1;
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
        ABOVE_3: begin
            if (s[3]) begin
                next_state = ABOVE_3;
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
            end
            else if (s[2]) begin
                next_state = BETWEEN_3_2;
                fr3 <= 1'b1;
                fr2 <= 1'b0;
                fr1 <= 1'b1;
                dfr <= 1'b0;
            end
            else if (s[1]) begin
                next_state = BETWEEN_2_1;
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
            end
            else begin
                next_state = BELOW_1;
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
            end
        end
        BETWEEN_3_2: begin
            if (s[3]) begin
                next_state = ABOVE_3;
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
            end
            else if (s[2]) begin
                next_state = BETWEEN_3_2;
                fr3 <= 1'b1;
                fr2 <= 1'b0;
                fr1 <= 1'b1;
                dfr <= 1'b0;
            end
            else if (s[1]) begin
                next_state = BETWEEN_2_1;
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
            end
            else begin
                next_state = BELOW_1;
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
            end
        end
        BETWEEN_2_1: begin
            if (s[3]) begin
                next_state = ABOVE_3;
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
            end
            else if (s[2]) begin
                next_state = BETWEEN_3_2;
                fr3 <= 1'b1;
                fr2 <= 1'b0;
                fr1 <= 1'b1;
                dfr <= 1'b0;
            end
            else if (s[1]) begin
                next_state = BETWEEN_2_1;
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
            end
            else begin
                next_state = BELOW_1;
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
            end
        end
        BELOW_1: begin
            if (s[3]) begin
                next_state = ABOVE_3;
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
            end
            else if (s[2]) begin
                next_state = BETWEEN_3_2;
                fr3 <= 1'b1;
                fr2 <= 1'b0;
                fr1 <= 1'b1;
                dfr <= 1'b0;
            end
            else if (s[1]) begin
                next_state = BETWEEN_2_1;
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
            end
            else begin
                next_state = BELOW_1;
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
            end
        end
    endcase
end

endmodule
