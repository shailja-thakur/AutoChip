module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // Define state and next state variables
    typedef enum reg [1:0] {
        LOW_LEVEL = 2'b00,  // Below s[1]
        MID_LEVEL = 2'b01,  // Between s[2] and s[1]
        HIGH_LEVEL = 2'b10, // Between s[3] and s[2]
        ABOVE_HIGH = 2'b11  // Above s[3]
    } state_t;

    state_t state, next_state;

    // State machine sequential logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW_LEVEL;  // Reset state to LOW_LEVEL
        end else begin
            state <= next_state;
        end
    end

    // State machine combinational logic
    always @(*) begin
        // Default outputs and next state
        fr3 = 0;
        fr2 = 0;
        fr1 = 0;
        dfr = 0;
        next_state = state;

        case (state)
            LOW_LEVEL: begin
                fr3 = 1;
                fr2 = 1;
                fr1 = 1;
                if (s == 3'b001) begin
                    next_state = MID_LEVEL;
                end else if (s == 3'b011) begin
                    next_state = HIGH_LEVEL;
                end else if (s == 3'b111) begin
                    next_state = ABOVE_HIGH;
                end
            end

            MID_LEVEL: begin
                fr2 = 1;
                fr1 = 1;
                if (s == 3'b000) begin
                    next_state = LOW_LEVEL;
                end else if (s == 3'b011) begin
                    next_state = HIGH_LEVEL;
                end else if (s == 3'b111) begin
                    next_state = ABOVE_HIGH;
                    dfr = 1;
                end
            end

            HIGH_LEVEL: begin
                fr1 = 1;
                if (s == 3'b000) begin
                    next_state = LOW_LEVEL;
                end else if (s == 3'b001) begin
                    next_state = MID_LEVEL;
                    dfr = 1;
                end else if (s == 3'b111) begin
                    next_state = ABOVE_HIGH;
                end
            end

            ABOVE_HIGH: begin
                if (s == 3'b000) begin
                    next_state = LOW_LEVEL;
                end else if (s == 3'b001) begin
                    next_state = MID_LEVEL;
                end else if (s == 3'b011) begin
                    next_state = HIGH_LEVEL;
                end
            end

            default: begin
                next_state = LOW_LEVEL;
            end
        endcase
    end

endmodule
