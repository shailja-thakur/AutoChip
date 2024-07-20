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
    reg prev_water_level;

    // State Encoding
    parameter LOW = 2'b00, MID_LOW = 2'b01, MID_HIGH = 2'b10, HIGH = 2'b11;

    // State transition logic
    always @(*) begin
        case (state)
            LOW: begin
                if (s[3])
                    next_state = HIGH;
                else if (s[2])
                    next_state = MID_HIGH;
                else if (s[1])
                    next_state = MID_LOW;
                else
                    next_state = LOW;
            end
            MID_LOW: begin
                if (s[3])
                    next_state = HIGH;
                else if (s[2])
                    next_state = MID_HIGH;
                else if (s[1])
                    next_state = MID_LOW;
                else
                    next_state = LOW;
            end
            MID_HIGH: begin
                if (s[3])
                    next_state = HIGH;
                else if (s[2])
                    next_state = MID_HIGH;
                else if (s[1])
                    next_state = MID_LOW;
                else
                    next_state = LOW;
            end
            HIGH: begin
                if (s[3])
                    next_state = HIGH;
                else if (s[2])
                    next_state = MID_HIGH;
                else if (s[1])
                    next_state = MID_LOW;
                else
                    next_state = LOW;
            end
            default: next_state = LOW;
        endcase
    end

    // State update on clock edge and reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
            prev_water_level <= 0;
        end else begin
            state <= next_state;
            prev_water_level <= s[3] | s[2] | s[1];
        end
    end

    // Output logic
    always @(*) begin
        // Default values
        fr3 = 0;
        fr2 = 0;
        fr1 = 0;
        dfr = 0;

        case (state)
            LOW: begin
                fr1 = 1;
                fr2 = 1;
                fr3 = 1;
            end
            MID_LOW: begin
                fr1 = 1;
                fr2 = 1;
                if (!prev_water_level)
                    dfr = 1;
            end
            MID_HIGH: begin
                fr1 = 1;
                if (!prev_water_level)
                    dfr = 1;
            end
            HIGH: begin
                // fr1, fr2, fr3, dfr are already set to 0 by default
            end
        endcase
    end

endmodule
