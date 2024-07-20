module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

    // State encoding
    typedef enum logic [1:0] {
        LOW = 2'b00,
        MID1 = 2'b01,
        MID2 = 2'b10,
        HIGH = 2'b11
    } state_t;

    state_t state, next_state;
    reg previous_level_higher;

    // Sequential logic for state transitions
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
            previous_level_higher <= 0;
        end
        else begin
            state <= next_state;
            if (next_state == state)
                previous_level_higher <= previous_level_higher;
            else
                previous_level_higher <= (next_state > state);
        end
    end

    // Combinational logic for next state determination
    always @(*) begin
        case (s)
            3'b000: next_state = LOW;
            3'b001: next_state = MID1;
            3'b011: next_state = MID2;
            3'b111: next_state = HIGH;
            default: next_state = LOW;
        endcase
    end

    // Combinational logic for output generation
    always @(*) begin
        // Default values
        fr3 = 0;
        fr2 = 0;
        fr1 = 0;
        dfr = 0;

        case (state)
            LOW: begin
                fr3 = 1;
                fr2 = 1;
                fr1 = 1;
            end
            MID1: begin
                fr2 = 1;
                fr1 = 1;
            end
            MID2: begin
                fr1 = 1;
            end
            HIGH: begin
                // No flow rates asserted
            end
        endcase

        // Additional logic for previous level indication
        if (previous_level_higher && state != HIGH) begin
            dfr = 1;
        end
    end
endmodule
