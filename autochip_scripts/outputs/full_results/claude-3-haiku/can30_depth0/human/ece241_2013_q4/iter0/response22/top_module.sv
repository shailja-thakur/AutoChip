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
parameter LEVEL_HIGH = 2'b11, LEVEL_MEDIUM = 2'b10, LEVEL_LOW = 2'b01, LEVEL_EMPTY = 2'b00;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= LEVEL_EMPTY;
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
        LEVEL_HIGH: begin
            fr3 = 1'b0;
            fr2 = 1'b0;
            fr1 = 1'b0;
            dfr = 1'b0;
            if (s[3]) begin
                next_state = LEVEL_HIGH;
            end
            else if (s[2]) begin
                next_state = LEVEL_MEDIUM;
            end
            else if (s[1]) begin
                next_state = LEVEL_LOW;
            end
            else begin
                next_state = LEVEL_EMPTY;
            end
        end
        LEVEL_MEDIUM: begin
            fr3 = 1'b0;
            fr2 = 1'b0;
            fr1 = 1'b1;
            dfr = 1'b0;
            if (s[3]) begin
                next_state = LEVEL_HIGH;
            end
            else if (s[2]) begin
                next_state = LEVEL_MEDIUM;
            end
            else if (s[1]) begin
                next_state = LEVEL_LOW;
            end
            else begin
                next_state = LEVEL_EMPTY;
            end
        end
        LEVEL_LOW: begin
            fr3 = 1'b0;
            fr2 = 1'b1;
            fr1 = 1'b1;
            dfr = 1'b1;
            if (s[3]) begin
                next_state = LEVEL_HIGH;
            end
            else if (s[2]) begin
                next_state = LEVEL_MEDIUM;
            end
            else if (s[1]) begin
                next_state = LEVEL_LOW;
            end
            else begin
                next_state = LEVEL_EMPTY;
            end
        end
        LEVEL_EMPTY: begin
            fr3 = 1'b1;
            fr2 = 1'b1;
            fr1 = 1'b1;
            dfr = 1'b1;
            if (s[3]) begin
                next_state = LEVEL_HIGH;
            end
            else if (s[2]) begin
                next_state = LEVEL_MEDIUM;
            end
            else if (s[1]) begin
                next_state = LEVEL_LOW;
            end
            else begin
                next_state = LEVEL_EMPTY;
            end
        end
    endcase
end

endmodule
