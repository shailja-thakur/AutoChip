module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // States for previous sensor levels
    typedef enum reg [1:0] {
        LOW = 2'b00,
        MID = 2'b01,
        HIGH = 2'b10,
        ABOVE_HIGH = 2'b11
    } state_t;

    state_t current_state;
    state_t next_state;

    // State transition and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= LOW;
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b1;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        // Default values
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b0;
        dfr = 1'b0;

        case (current_state)
            ABOVE_HIGH: begin
                if (s[3]) begin
                    next_state = ABOVE_HIGH;
                end else if (s[2]) begin
                    next_state = HIGH;
                    fr1 = 1'b1;
                end else if (s[1]) begin
                    next_state = MID;
                    fr1 = 1'b1;
                    fr2 = 1'b1;
                end else begin
                    next_state = LOW;
                    fr1 = 1'b1;
                    fr2 = 1'b1;
                    fr3 = 1'b1;
                end
            end

            HIGH: begin
                if (s[3]) begin
                    next_state = ABOVE_HIGH;
                end else if (s[2]) begin
                    next_state = HIGH;
                    fr1 = 1'b1;
                end else if (s[1]) begin
                    next_state = MID;
                    fr1 = 1'b1;
                    fr2 = 1'b1;

                    // If transitioning to a higher water level, open the supplemental valve
                    if (current_state == MID) dfr = 1'b1;
                end else begin
                    next_state = LOW;
                    fr1 = 1'b1;
                    fr2 = 1'b1;
                    fr3 = 1'b1;
                end
            end

            MID: begin
                if (s[3]) begin
                    next_state = ABOVE_HIGH;
                end else if (s[2]) begin
                    next_state = HIGH;
                    fr1 = 1'b1;

                    // If transitioning to a higher water level, open the supplemental valve
                    if (current_state == LOW) dfr = 1'b1;
                end else if (s[1]) begin
                    next_state = MID;
                    fr1 = 1'b1;
                    fr2 = 1'b1;
                end else begin
                    next_state = LOW;
                    fr1 = 1'b1;
                    fr2 = 1'b1;
                    fr3 = 1'b1;
                end
            end

            LOW: begin
                if (s[3]) begin
                    next_state = ABOVE_HIGH;
                end else if (s[2]) begin
                    next_state = HIGH;
                    fr1 = 1'b1;
                end else if (s[1]) begin
                    next_state = MID;
                    fr1 = 1'b1;
                    fr2 = 1'b1;
                end else begin
                    next_state = LOW;
                    fr1 = 1'b1;
                    fr2 = 1'b1;
                    fr3 = 1'b1;
                end
            end

            default: begin
                next_state = LOW;
            end
        endcase
    end
endmodule
