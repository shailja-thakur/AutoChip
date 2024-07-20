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
        MID_LOW = 2'b01,
        MID_HIGH = 2'b10,
        HIGH = 2'b11
    } state_t;

    state_t state, next_state;
    state_t prev_state;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
            prev_state <= LOW;
            fr3 <= 1;
            fr2 <= 1;
            fr1 <= 1;
            dfr <= 1;
        end else begin
            state <= next_state;
            if (state != next_state) begin
                prev_state <= state;
            end
        end
    end

    // Next state logic based on sensor inputs
    always_comb begin
        case (s)
            3'b000: next_state = LOW;
            3'b001: next_state = MID_LOW;
            3'b011: next_state = MID_HIGH;
            3'b111: next_state = HIGH;
            default: next_state = LOW;
        endcase
    end

    // Output logic based on current state
    always_comb begin
        case (state)
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
                dfr = (prev_state == LOW) ? 1 : 0;
            end
            MID_HIGH: begin
                fr3 = 0;
                fr2 = 0;
                fr1 = 1;
                dfr = (prev_state == MID_LOW) ? 1 : 0;
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
                dfr = 1;
            end
        endcase
    end
endmodule
