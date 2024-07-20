module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // State enumeration
    reg [1:0] state, next_state;
    parameter LOW = 2'b00, BETWEEN_LOW_MED = 2'b01, BETWEEN_MED_HIGH = 2'b10, HIGH = 2'b11;

    // Previous level for determining dfr
    reg last_level_low;

    // Sequential logic for state transitions and previous state tracking
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
            last_level_low <= 1;
        end else begin
            state <= next_state;
            last_level_low <= (state == LOW) ? 1 : 0;
        end
    end

    // Combinational logic for next state and outputs
    always @(*) begin
        // Default values
        next_state = state;
        fr3 = 0;
        fr2 = 0;
        fr1 = 0;
        dfr = 0;

        case(state)
            LOW: begin
                if (s == 3'b111) next_state = HIGH;
                else if (s == 3'b011) next_state = BETWEEN_MED_HIGH;
                else if (s == 3'b001) next_state = BETWEEN_LOW_MED;
                fr3 = 1;
                fr2 = 1;
                fr1 = 1;
            end
            BETWEEN_LOW_MED: begin
                if (s == 3'b111) next_state = HIGH;
                else if (s == 3'b011) next_state = BETWEEN_MED_HIGH;
                else if (s == 3'b000) next_state = LOW;
                fr2 = 1;
                fr1 = 1;
                if (last_level_low) dfr = 1;
            end
            BETWEEN_MED_HIGH: begin
                if (s == 3'b111) next_state = HIGH;
                else if (s == 3'b001) next_state = BETWEEN_LOW_MED;
                else if (s == 3'b000) next_state = LOW;
                fr1 = 1;
                if (last_level_low) dfr = 1;
            end
            HIGH: begin
                if (s != 3'b111) begin
                    if (s == 3'b011) next_state = BETWEEN_MED_HIGH;
                    else if (s == 3'b001) next_state = BETWEEN_LOW_MED;
                    else if (s == 3'b000) next_state = LOW;
                end
            end
        endcase
    end

endmodule
