module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // States for internal state machine
    typedef enum logic [1:0] {
        LOW_WATER_LEVEL = 2'd0,       // All sensors off
        BETWEEN_S1_S2 = 2'd1,         // s[1] on
        BETWEEN_S2_S3 = 2'd2,         // s[1] and s[2] on
        ABOVE_S3 = 2'd3               // s[1], s[2], and s[3] on
    } state_t;

    state_t state, next_state;
    reg previous_lower;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW_WATER_LEVEL;
            previous_lower <= 1'b1;
        end else begin
            state <= next_state;
            if (s < state) begin
                previous_lower <= 1'b1;
            end else if (s > state) begin
                previous_lower <= 1'b0;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (s)
            3'b000: next_state = LOW_WATER_LEVEL;
            3'b001: next_state = BETWEEN_S2_S3;
            3'b011: next_state = BETWEEN_S2_S3;
            3'b111: next_state = ABOVE_S3;
            default: next_state = LOW_WATER_LEVEL;
        endcase
    end

    // Output logic
    always_comb begin
        // Reset all outputs
        fr1 = 1'b0;
        fr2 = 1'b0;
        fr3 = 1'b0;
        dfr = 1'b0;

        case (state)
            LOW_WATER_LEVEL: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                fr3 = 1'b1;
                if (!previous_lower) begin
                    dfr = 1'b1;
                end
            end
            BETWEEN_S1_S2: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                if (!previous_lower) begin
                    dfr = 1'b1;
                end
            end
            BETWEEN_S2_S3: begin
                fr1 = 1'b1;
                if (!previous_lower) begin
                    dfr = 1'b1;
                end
            end
            ABOVE_S3: begin
                // No outputs set
            end
        endcase
    end
endmodule
