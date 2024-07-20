module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // Define states
    typedef enum logic [1:0] {
        HIGH_LEVEL = 2'b00,       // Above s[3]
        MID_LEVEL_HIGH = 2'b01,   // Between s[3] and s[2]
        MID_LEVEL_LOW = 2'b10,    // Between s[2] and s[1]
        LOW_LEVEL = 2'b11         // Below s[1]
    } state_t;

    state_t current_state, next_state;
    reg previous_level_low;
    
    // State transitions and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= LOW_LEVEL;
            fr3 <= 1;
            fr2 <= 1;
            fr1 <= 1;
            dfr <= 1;
            previous_level_low <= 1;
        end else begin
            current_state <= next_state;

            // Determine previous level was low or high
            previous_level_low <= (s == 3'b000);

            case (next_state)
                HIGH_LEVEL: begin
                    fr1 <= 0;
                    fr2 <= 0;
                    fr3 <= 0;
                    dfr <= 0;
                end
                MID_LEVEL_HIGH: begin
                    fr1 <= 1;
                    fr2 <= 0;
                    fr3 <= 0;
                    dfr <= 0;
                end
                MID_LEVEL_LOW: begin
                    fr1 <= 1;
                    fr2 <= 1;
                    fr3 <= 0;
                    dfr <= previous_level_low ? 1 : 0;
                end
                LOW_LEVEL: begin
                    fr1 <= 1;
                    fr2 <= 1;
                    fr3 <= 1;
                    dfr <= 1;
                end
            endcase
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            HIGH_LEVEL: begin
                if (s == 3'b110) begin
                    next_state = MID_LEVEL_HIGH;
                end else if (s == 3'b100) begin
                    next_state = MID_LEVEL_LOW;
                end else if (s == 3'b000) begin
                    next_state = LOW_LEVEL;
                end else begin
                    next_state = HIGH_LEVEL;
                end
            end
            MID_LEVEL_HIGH: begin
                if (s == 3'b111) begin
                    next_state = HIGH_LEVEL;
                end else if (s == 3'b100) begin
                    next_state = MID_LEVEL_LOW;
                end else if (s == 3'b000) begin
                    next_state = LOW_LEVEL;
                end else begin
                    next_state = MID_LEVEL_HIGH;
                end
            end
            MID_LEVEL_LOW: begin
                if (s == 3'b111) begin
                    next_state = HIGH_LEVEL;
                end else if (s == 3'b110) begin
                    next_state = MID_LEVEL_HIGH;
                end else if (s == 3'b000) begin
                    next_state = LOW_LEVEL;
                end else begin
                    next_state = MID_LEVEL_LOW;
                end
            end
            LOW_LEVEL: begin
                if (s == 3'b111) begin
                    next_state = HIGH_LEVEL;
                end else if (s == 3'b110) begin
                    next_state = MID_LEVEL_HIGH;
                end else if (s == 3'b100) begin
                    next_state = MID_LEVEL_LOW;
                end else begin
                    next_state = LOW_LEVEL;
                end
            end
            default: next_state = LOW_LEVEL;
        endcase
    end
endmodule
