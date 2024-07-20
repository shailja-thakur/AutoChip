module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // States for the state machine
    typedef enum reg [1:0] {
        LOW = 2'b00,
        MID_LOW = 2'b01,
        MID_HIGH = 2'b10,
        HIGH = 2'b11
    } state_t;

    state_t current_state, next_state;
    reg [3:1] prev_s;

    // State transition logic
    always @(*) begin
        case(current_state)
            LOW: begin
                if (s == 3'b000)
                    next_state = LOW;
                else if (s == 3'b001)
                    next_state = MID_LOW;
                else if (s == 3'b011)
                    next_state = MID_HIGH;
                else if (s == 3'b111)
                    next_state = HIGH;
                else
                    next_state = LOW;
            end
            MID_LOW: begin
                if (s == 3'b000)
                    next_state = LOW;
                else if (s == 3'b001)
                    next_state = MID_LOW;
                else if (s == 3'b011)
                    next_state = MID_HIGH;
                else if (s == 3'b111)
                    next_state = HIGH;
                else
                    next_state = MID_LOW;
            end
            MID_HIGH: begin
                if (s == 3'b000)
                    next_state = LOW;
                else if (s == 3'b001)
                    next_state = MID_LOW;
                else if (s == 3'b011)
                    next_state = MID_HIGH;
                else if (s == 3'b111)
                    next_state = HIGH;
                else
                    next_state = MID_HIGH;
            end
            HIGH: begin
                if (s == 3'b000)
                    next_state = LOW;
                else if (s == 3'b001)
                    next_state = MID_LOW;
                else if (s == 3'b011)
                    next_state = MID_HIGH;
                else if (s == 3'b111)
                    next_state = HIGH;
                else
                    next_state = HIGH;
            end
            default: next_state = LOW;
        endcase
    end

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= LOW;
            prev_s <= 0;
        end else begin
            current_state <= next_state;
            prev_s <= s;
        end
    end

    // Output logic based on the state
    always @(*) begin
        case (current_state)
            LOW: begin
                fr3 = 1;
                fr2 = 1;
                fr1 = 1;
                dfr = 0;
            end
            MID_LOW: begin
                fr3 = 0;
                fr2 = 1;
                fr1 = 1;
                dfr = (s > prev_s) ? 1 : 0;
            end
            MID_HIGH: begin
                fr3 = 0;
                fr2 = 0;
                fr1 = 1;
                dfr = (s > prev_s) ? 1 : 0;
            end
            HIGH: begin
                fr3 = 0;
                fr2 = 0;
                fr1 = 0;
                dfr = 0;
            end
            default: begin
                fr3 = 1;
                fr2 = 1;
                fr1 = 1;
                dfr = 0;
            end
        endcase
    end

endmodule
