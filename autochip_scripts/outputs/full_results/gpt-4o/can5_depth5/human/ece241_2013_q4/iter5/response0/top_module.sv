module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    typedef enum logic [1:0] {
        LOW = 2'b00,
        MID = 2'b01,
        HIGH = 2'b10,
        FULL = 2'b11
    } state_t;

    state_t state, next_state;
    reg [3:1] previous_sensors;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
            previous_sensors <= 3'b000;
        end else begin
            state <= next_state;
            previous_sensors <= s;
        end
    end

    always @(*) begin
        case (state)
            FULL: begin
                if (s == 3'b111)
                    next_state = FULL;
                else if (s == 3'b011)
                    next_state = HIGH;
                else if (s == 3'b001)
                    next_state = MID;
                else
                    next_state = LOW;
            end
            HIGH: begin
                if (s == 3'b111)
                    next_state = FULL;
                else if (s == 3'b011)
                    next_state = HIGH;
                else if (s == 3'b001)
                    next_state = MID;
                else
                    next_state = LOW;
            end
            MID: begin
                if (s == 3'b111)
                    next_state = FULL;
                else if (s == 3'b011)
                    next_state = HIGH;
                else if (s == 3'b001)
                    next_state = MID;
                else
                    next_state = LOW;
            end
            LOW: begin
                if (s == 3'b111)
                    next_state = FULL;
                else if (s == 3'b011)
                    next_state = HIGH;
                else if (s == 3'b001)
                    next_state = MID;
                else
                    next_state = LOW;
            end
            default: begin
                next_state = LOW;
            end
        endcase
    end

    always @(*) begin
        // Default values
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b0;
        dfr = 1'b0;

        case (state)
            FULL: begin
                fr3 = 1'b0;
                fr2 = 1'b0;
                fr1 = 1'b0;
                dfr = 1'b0;
            end
            HIGH: begin
                fr3 = 1'b0;
                fr2 = 1'b0;
                fr1 = 1'b1;
                dfr = (previous_sensors != 3'b111) ? 1'b1 : 1'b0;
            end
            MID: begin
                fr3 = 1'b0;
                fr2 = 1'b1;
                fr1 = 1'b1;
                dfr = (previous_sensors != 3'b011) ? 1'b1 : 1'b0;
            end
            LOW: begin
                fr3 = 1'b1;
                fr2 = 1'b1;
                fr1 = 1'b1;
                dfr = 1'b1;
            end
        endcase
    end

endmodule
