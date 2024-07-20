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
        BETWEEN_LOW_AND_MEDIUM = 2'b01,
        BETWEEN_MEDIUM_AND_HIGH = 2'b10,
        HIGH = 2'b11
    } state_t;

    state_t state, next_state;

    // State machine
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and outputs
    always_comb begin
        // Default assignments
        fr1 = 1'b0;
        fr2 = 1'b0;
        fr3 = 1'b0;
        dfr = 1'b0;

        case (state)
            LOW: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                fr3 = 1'b1;
                if (s[1]) begin
                    next_state = BETWEEN_LOW_AND_MEDIUM;
                end else begin
                    next_state = LOW;
                end
            end

            BETWEEN_LOW_AND_MEDIUM: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                if (s[2]) begin
                    next_state = BETWEEN_MEDIUM_AND_HIGH;
                end else if (!s[1]) begin
                    next_state = LOW;
                end else begin
                    next_state = BETWEEN_LOW_AND_MEDIUM;
                end
            end

            BETWEEN_MEDIUM_AND_HIGH: begin
                fr1 = 1'b1;
                if (s[3]) begin
                    next_state = HIGH;
                end else if (!s[2]) begin
                    next_state = BETWEEN_LOW_AND_MEDIUM;
                end else begin
                    next_state = BETWEEN_MEDIUM_AND_HIGH;
                end
            end

            HIGH: begin
                if (!s[3]) begin
                    next_state = BETWEEN_MEDIUM_AND_HIGH;
                end else begin
                    next_state = HIGH;
                end
            end
        endcase

        // Determine dfr output based on transition
        // Increase flow rate if the water level has risen
        if (state < next_state) begin
            dfr = 1'b1;
        end else begin
            dfr = 1'b0;
        end
    end

endmodule
