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
parameter STATE_HIGH = 2'b00, // Water level above s[3]
          STATE_MEDIUM = 2'b01, // Water level between s[3] and s[1]
          STATE_LOW = 2'b11; // Water level below s[1]

reg [1:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_LOW;
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
    // Determine the next state based on the current water level
    next_state = state;
    case (s)
        3'b111: next_state = STATE_HIGH;
        3'b011: next_state = STATE_MEDIUM;
        3'b001: next_state = STATE_MEDIUM;
        3'b000: next_state = STATE_LOW;
    endcase

    // Set the output signals based on the current state
    case (next_state)
        STATE_HIGH: begin
            fr3 = 1'b0;
            fr2 = 1'b0;
            fr1 = 1'b0;
            dfr = 1'b0;
        end
        STATE_MEDIUM: begin
            fr3 = 1'b0;
            fr2 = 1'b0;
            fr1 = 1'b1;
            dfr = (state == STATE_LOW) ? 1'b1 : 1'b0; // Increase flow rate if previous level was lower
        end
        STATE_LOW: begin
            fr3 = 1'b1;
            fr2 = 1'b1;
            fr1 = 1'b1;
            dfr = 1'b1;
        end
    endcase
end

endmodule
