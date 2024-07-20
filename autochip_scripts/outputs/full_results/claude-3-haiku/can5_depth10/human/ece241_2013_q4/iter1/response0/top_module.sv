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
parameter LEVEL_HIGH = 2'b00, LEVEL_MID = 2'b01, LEVEL_LOW = 2'b10, LEVEL_EMPTY = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= LEVEL_EMPTY;
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
    // Default outputs
    fr3 = 1'b0;
    fr2 = 1'b0;
    fr1 = 1'b0;
    dfr = 1'b0;

    case (state)
        LEVEL_HIGH: begin
            // Water level is above the highest sensor s[3]
            // Nominal flow rate is 0
        end
        LEVEL_MID: begin
            // Water level is between the upper and lower sensors
            // Nominal flow rate is fr1
            fr1 = 1'b1;
            if (s[1] == 1'b0) begin
                // Previous level was lower than current level
                // Increase flow rate by opening the Supplemental flow valve
                dfr = 1'b1;
            end
        end
        LEVEL_LOW: begin
            // Water level is below the lowest sensor s[1]
            // Nominal flow rate is fr1 and fr2
            fr1 = 1'b1;
            fr2 = 1'b1;
            // Open the Supplemental flow valve
            dfr = 1'b1;
        end
        LEVEL_EMPTY: begin
            // Water level is below s[1]
            // Nominal flow rate is fr1, fr2, and fr3
            fr1 = 1'b1;
            fr2 = 1'b1;
            fr3 = 1'b1;
            // Open the Supplemental flow valve
            dfr = 1'b1;
        end
        default: begin
            // Invalid state, handle accordingly
        end
    endcase

    // Update next state
    if (s[3] == 1'b1) begin
        next_state = LEVEL_HIGH;
    end
    else if (s[2] == 1'b1) begin
        next_state = LEVEL_MID;
    end
    else if (s[1] == 1'b1) begin
        next_state = LEVEL_LOW;
    end
    else begin
        next_state = LEVEL_EMPTY;
    end
end

endmodule
