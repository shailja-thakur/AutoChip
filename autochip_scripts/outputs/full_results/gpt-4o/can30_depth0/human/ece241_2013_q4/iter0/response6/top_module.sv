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
        BELOW_S1 = 2'b00,
        BETWEEN_S2_AND_S1 = 2'b01,
        BETWEEN_S3_AND_S2 = 2'b10,
        ABOVE_S3 = 2'b11
    } state_t;

    state_t state, next_state;

    // Sequential logic for state transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BELOW_S1;
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state and output logic
    always_comb begin
        // Default values
        next_state = state;
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b0;
        dfr = 1'b0;
        
        // State Transition Logic
        case (state)
            BELOW_S1: begin
                if (s == 3'b000) begin // No sensors asserted
                    fr3 = 1'b1;
                    fr2 = 1'b1;
                    fr1 = 1'b1;
                    dfr = 1'b1;
                    next_state = BELOW_S1;
                end
                else if (s == 3'b001) begin // Only s[1] asserted
                    next_state = BETWEEN_S2_AND_S1;
                end
                else if (s == 3'b011) begin // s[1] and s[2] asserted
                    next_state = BETWEEN_S3_AND_S2;
                end
                else if (s == 3'b111) begin // s[1], s[2], and s[3] asserted
                    next_state = ABOVE_S3;
                end
            end

            BETWEEN_S2_AND_S1: begin
                if (s == 3'b000) begin // No sensors asserted
                    fr3 = 1'b1;
                    fr2 = 1'b1;
                    fr1 = 1'b1;
                    dfr = 1'b1;
                    next_state = BELOW_S1;
                end
                else if (s == 3'b001) begin // Only s[1] asserted
                    fr1 = 1'b1;
                    fr2 = 1'b1;
                    next_state = BETWEEN_S2_AND_S1;
                    dfr = (state == BELOW_S1); // Open supplemental flow valve if previous state was below
                end
                else if (s == 3'b011) begin // s[1] and s[2] asserted
                    next_state = BETWEEN_S3_AND_S2;
                end
                else if (s == 3'b111) begin // s[1], s[2], and s[3] asserted
                    next_state = ABOVE_S3;
                end
            end

            BETWEEN_S3_AND_S2: begin
                if (s == 3'b000) begin // No sensors asserted
                    fr3 = 1'b1;
                    fr2 = 1'b1;
                    fr1 = 1'b1;
                    dfr = 1'b1;
                    next_state = BELOW_S1;
                end
                else if (s == 3'b001) begin // Only s[1] asserted
                    next_state = BETWEEN_S2_AND_S1;
                end
                else if (s == 3'b011) begin // s[1] and s[2] asserted
                    fr1 = 1'b1;
                    next_state = BETWEEN_S3_AND_S2;
                    dfr = (state == BETWEEN_S2_AND_S1); // Open supplemental flow valve if previous state was between s[2] and s[1]
                end
                else if (s == 3'b111) begin // s[1], s[2], and s[3] asserted
                    next_state = ABOVE_S3;
                end
            end

            ABOVE_S3: begin
                if (s == 3'b000) begin // No sensors asserted
                    fr3 = 1'b1;
                    fr2 = 1'b1;
                    fr1 = 1'b1;
                    dfr = 1'b1;
                    next_state = BELOW_S1;
                end
                else if (s == 3'b001) begin // Only s[1] asserted
                    next_state = BETWEEN_S2_AND_S1;
                end
                else if (s == 3'b011) begin // s[1] and s[2] asserted
                    next_state = BETWEEN_S3_AND_S2;
                end
                else if (s == 3'b111) begin // s[1], s[2], and s[3] asserted
                    next_state = ABOVE_S3;
                end
            end
        endcase
    end

endmodule
