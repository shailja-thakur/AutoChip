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
        LOWEST = 2'b00,
        BETWEEN_S1_S2 = 2'b01,
        BETWEEN_S2_S3 = 2'b10,
        ABOVE_S3 = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State register logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= LOWEST;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state and output logic
    always @(*) begin
        // Default values
        next_state = current_state;
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b0;
        dfr = 1'b0;

        case (current_state)
            LOWEST: begin
                fr3 = 1'b1;
                fr2 = 1'b1;
                fr1 = 1'b1;
                if (s[1]) begin
                    next_state = BETWEEN_S1_S2;
                end
            end
            BETWEEN_S1_S2: begin
                fr2 = 1'b1;
                fr1 = 1'b1;
                if (s[2]) begin
                    next_state = BETWEEN_S2_S3;
                end else if (!s[1]) begin
                    next_state = LOWEST;
                end
            end
            BETWEEN_S2_S3: begin
                fr1 = 1'b1;
                if (s[3]) begin
                    next_state = ABOVE_S3;
                end else if (!s[2]) begin
                    next_state = BETWEEN_S1_S2;
                end
            end
            ABOVE_S3: begin
                if (!s[3]) begin
                    next_state = BETWEEN_S2_S3;
                end
            end
            default: begin
                next_state = LOWEST;
            end
        endcase

        // Determine if dfr should be asserted
        if (next_state > current_state) begin
            dfr = 1'b1;
        end

        // If reset is asserted, all outputs should be high
        if (reset) begin
            fr3 = 1'b1;
            fr2 = 1'b1;
            fr1 = 1'b1;
            dfr = 1'b0;
        end
    end
endmodule
