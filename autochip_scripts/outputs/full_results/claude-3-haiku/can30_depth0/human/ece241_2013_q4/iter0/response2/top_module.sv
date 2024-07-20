module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

// Define the states of the state machine
localparam STATE_HIGH = 3'b111,
           STATE_MEDIUM_HIGH = 3'b110,
           STATE_MEDIUM_LOW = 3'b100,
           STATE_LOW = 3'b000;

reg [2:0] state, next_state;

// State transition logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_LOW;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    // Default values
    fr3 = 1'b0;
    fr2 = 1'b0;
    fr1 = 1'b0;
    dfr = 1'b0;

    case (state)
        STATE_HIGH: begin
            // Water level is above the highest sensor s[3]
            // No flow rate inputs should be asserted
        end
        STATE_MEDIUM_HIGH: begin
            // Water level is between s[3] and s[2]
            fr1 = 1'b1;
            if (s[1] == 1'b0) begin
                // Previous level was lower, so increase flow rate
                dfr = 1'b1;
            end
        end
        STATE_MEDIUM_LOW: begin
            // Water level is between s[2] and s[1]
            fr1 = 1'b1;
            fr2 = 1'b1;
            if (s[1] == 1'b0) begin
                // Previous level was lower, so increase flow rate
                dfr = 1'b1;
            end
        end
        STATE_LOW: begin
            // Water level is below the lowest sensor s[1]
            fr1 = 1'b1;
            fr2 = 1'b1;
            fr3 = 1'b1;
        end
    endcase

    // Determine the next state based on the current sensor inputs
    if (s == 3'b111) begin
        next_state = STATE_HIGH;
    end else if (s == 3'b110) begin
        next_state = STATE_MEDIUM_HIGH;
    end else if (s == 3'b100) begin
        next_state = STATE_MEDIUM_LOW;
    end else begin
        next_state = STATE_LOW;
    end
end

endmodule
