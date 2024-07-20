module top_module (
    input clk,
    input reset,
    input [3:1] s,  // Sensors s[3], s[2], and s[1]
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // State encoding
    enum logic [1:0] {
        LOW = 2'b00,      // Below s[1]
        BETWEEN1 = 2'b01, // Between s[2] and s[1]
        BETWEEN2 = 2'b10, // Between s[3] and s[2]
        HIGH = 2'b11      // Above s[3]
    } state, next_state;

    // Previous water level state for determining direction of flow change
    logic [1:0] prev_state;

    // State machine for water level
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
            prev_state <= LOW;
        end else begin
            state <= next_state;
            prev_state <= state;
        end
    end

    // Determine next state based on sensors
    always_comb begin
        case (s)
            3'b000: next_state = LOW;
            3'b001: next_state = BETWEEN1;
            3'b011: next_state = BETWEEN2;
            3'b111: next_state = HIGH;
            default: next_state = LOW; // Default to LOW to handle invalid sensor combinations
        endcase
    end
    
    // Determine outputs based on current state and previous state
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            fr3 <= 1;
            fr2 <= 1;
            fr1 <= 1;
            dfr <= 1;
        end else begin
            case (state)
                HIGH: begin
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 0;
                    dfr <= 0;
                end
                BETWEEN2: begin
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 1;
                    dfr <= prev_state < state ? 1 : 0; // Open supplemental flow valve if rising water level
                end
                BETWEEN1: begin
                    fr3 <= 0;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= prev_state < state ? 1 : 0; // Open supplemental flow valve if rising water level
                end
                LOW: begin
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
            endcase
        end
    end
endmodule
