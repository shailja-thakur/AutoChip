module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);
    reg [1:0] state, next_state;
    localparam  LOW = 2'b00,
                BETWEEN_LOW_MID = 2'b01,
                BETWEEN_MID_HIGH = 2'b10,
                HIGH = 2'b11;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            LOW: begin
                if (s[3]) 
                    next_state = HIGH;
                else if (s[2])
                    next_state = BETWEEN_MID_HIGH;
                else if (s[1])
                    next_state = BETWEEN_LOW_MID;
                else
                    next_state = LOW;
            end
            BETWEEN_LOW_MID: begin
                if (s[3])
                    next_state = HIGH;
                else if (s[2])
                    next_state = BETWEEN_MID_HIGH;
                else if (s[1])
                    next_state = BETWEEN_LOW_MID;
                else
                    next_state = LOW;
            end
            BETWEEN_MID_HIGH: begin
                if (s[3])
                    next_state = HIGH;
                else if (s[2])
                    next_state = BETWEEN_MID_HIGH;
                else if (s[1])
                    next_state = BETWEEN_LOW_MID;
                else
                    next_state = LOW;
            end
            HIGH: begin
                if (s[3])
                    next_state = HIGH;
                else if (s[2])
                    next_state = BETWEEN_MID_HIGH;
                else if (s[1])
                    next_state = BETWEEN_LOW_MID;
                else
                    next_state = LOW;
            end
            default: next_state = LOW;
        endcase
    end

    always @(*) begin
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b0;
        dfr = 1'b0;
        case (state)
            LOW: begin
                fr3 = 1'b1;
                fr2 = 1'b1;
                fr1 = 1'b1;
                dfr = 1'b0;
            end
            BETWEEN_LOW_MID: begin
                fr2 = 1'b1;
                fr1 = 1'b1;
                if (next_state == LOW) begin
                    dfr = 1'b1;
                end
            end
            BETWEEN_MID_HIGH: begin
                fr1 = 1'b1;
                if (next_state == BETWEEN_LOW_MID) begin
                    dfr = 1'b1;
                end
            end
            HIGH: begin
                fr3 = 1'b0;
                fr2 = 1'b0;
                fr1 = 1'b0;
                dfr = 1'b0;
            end
        endcase
    end
endmodule
