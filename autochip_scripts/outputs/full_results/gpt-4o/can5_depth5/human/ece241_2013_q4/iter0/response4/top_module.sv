module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    typedef enum reg [1:0] {
        LOW = 2'b00,    // No sensors asserted, maximum flow rate
        BETWEEN_LOW_MID = 2'b01,  // Sensor s[1] asserted
        BETWEEN_MID_HIGH = 2'b10, // Sensors s[1] and s[2] asserted
        HIGH = 2'b11    // Sensors s[1], s[2], and s[3] asserted
    } water_level_t;

    water_level_t current_state, next_state;
    reg previous_level_increase;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= LOW;
            previous_level_increase <= 0;
        end else begin
            current_state <= next_state;
            if (current_state < next_state) begin
                previous_level_increase <= 1;
            end else if (current_state > next_state) begin
                previous_level_increase <= 0;
            end
        end
    end

    always @(*) begin
        fr3 = 0;
        fr2 = 0;
        fr1 = 0;
        dfr = 0;

        case (current_state)
            HIGH: begin
                // No flow rate
            end

            BETWEEN_MID_HIGH: begin
                fr1 = 1;
            end

            BETWEEN_LOW_MID: begin
                fr1 = 1;
                fr2 = 1;
            end

            LOW: begin
                fr1 = 1;
                fr2 = 1;
                fr3 = 1;
            end
        endcase

        if (previous_level_increase && current_state != HIGH) begin
            dfr = 1;
        end

        casez (s)
            3'b111: next_state = HIGH;
            3'b011: next_state = BETWEEN_MID_HIGH;
            3'b001: next_state = BETWEEN_LOW_MID;
            3'b000: next_state = LOW;
            default: next_state = LOW;
        endcase
    end

endmodule
