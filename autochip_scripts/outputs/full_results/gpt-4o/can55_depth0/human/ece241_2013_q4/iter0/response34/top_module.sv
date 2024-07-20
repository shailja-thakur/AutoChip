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

    // State encoding
    localparam LOW = 2'b00;
    localparam MID_LOW = 2'b01;
    localparam MID_HIGH = 2'b10;
    localparam HIGH = 2'b11;

    // State transition logic
    always @(*) begin
        case (state)
            LOW: begin
                if (s[1])
                    next_state = MID_LOW;
                else
                    next_state = LOW;
            end
            MID_LOW: begin
                if (s[2])
                    next_state = MID_HIGH;
                else if (~s[1])
                    next_state = LOW;
                else
                    next_state = MID_LOW;
            end
            MID_HIGH: begin
                if (s[3])
                    next_state = HIGH;
                else if (~s[2])
                    next_state = MID_LOW;
                else
                    next_state = MID_HIGH;
            end
            HIGH: begin
                if (~s[3])
                    next_state = MID_HIGH;
                else
                    next_state = HIGH;
            end
            default: next_state = LOW;
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= LOW;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b1;
        end else begin
            case (state)
                LOW: begin
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                end
                MID_LOW: begin
                    fr3 <= 1'b0;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= ~s[1];
                end
                MID_HIGH: begin
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b1;
                    dfr <= ~s[2];
                end
                HIGH: begin
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= ~s[3];
                end
                default: begin
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b1;
                end
            endcase
        end
    end
endmodule
