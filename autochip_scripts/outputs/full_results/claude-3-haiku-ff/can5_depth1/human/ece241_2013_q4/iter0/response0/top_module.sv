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
parameter LEVEL_HIGH = 2'b11, LEVEL_MEDIUM = 2'b10, LEVEL_LOW = 2'b01, LEVEL_CRITICAL = 2'b00;

always @(posedge clk) begin
    if (reset) begin
        current_state <= LEVEL_CRITICAL;
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
    // Default outputs
    fr3 = 0;
    fr2 = 0;
    fr1 = 0;
    dfr = 0;

    case (current_state)
        LEVEL_HIGH: begin
            if (s[3]) begin
                // Water level above highest sensor
                next_state = LEVEL_HIGH;
            end
            else if (s[2]) begin
                // Water level between s[3] and s[2]
                next_state = LEVEL_MEDIUM;
                fr1 = 1;
            end
            else if (s[1]) begin
                // Water level between s[2] and s[1]
                next_state = LEVEL_LOW;
                fr1 = 1;
                fr2 = 1;
            end
            else begin
                // Water level below s[1]
                next_state = LEVEL_CRITICAL;
                fr1 = 1;
                fr2 = 1;
                fr3 = 1;
                dfr = 1;
            end
        end
        LEVEL_MEDIUM: begin
            if (s[3]) begin
                // Water level above highest sensor
                next_state = LEVEL_HIGH;
            end
            else if (s[2]) begin
                // Water level between s[3] and s[2]
                next_state = LEVEL_MEDIUM;
                fr1 = 1;
            end
            else if (s[1]) begin
                // Water level between s[2] and s[1]
                next_state = LEVEL_LOW;
                fr1 = 1;
                fr2 = 1;
            end
            else begin
                // Water level below s[1]
                next_state = LEVEL_CRITICAL;
                fr1 = 1;
                fr2 = 1;
                fr3 = 1;
                dfr = 1;
            end
        end
        LEVEL_LOW: begin
            if (s[3]) begin
                // Water level above highest sensor
                next_state = LEVEL_HIGH;
            end
            else if (s[2]) begin
                // Water level between s[3] and s[2]
                next_state = LEVEL_MEDIUM;
                fr1 = 1;
            end
            else if (s[1]) begin
                // Water level between s[2] and s[1]
                next_state = LEVEL_LOW;
                fr1 = 1;
                fr2 = 1;
            end
            else begin
                // Water level below s[1]
                next_state = LEVEL_CRITICAL;
                fr1 = 1;
                fr2 = 1;
                fr3 = 1;
                dfr = 1;
            end
        end
        LEVEL_CRITICAL: begin
            if (s[3]) begin
                // Water level above highest sensor
                next_state = LEVEL_HIGH;
            end
            else if (s[2]) begin
                // Water level between s[3] and s[2]
                next_state = LEVEL_MEDIUM;
                fr1 = 1;
            end
            else if (s[1]) begin
                // Water level between s[2] and s[1]
                next_state = LEVEL_LOW;
                fr1 = 1;
                fr2 = 1;
            end
            else begin
                // Water level below s[1]
                next_state = LEVEL_CRITICAL;
                fr1 = 1;
                fr2 = 1;
                fr3 = 1;
                dfr = 1;
            end
        end
    endcase
end
endmodule
