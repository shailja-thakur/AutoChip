module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        PATTERN_DETECTED = 3'b001,
        SHIFTING = 3'b010,
        WAIT_COUNT = 3'b011,
        DONE = 3'b100
    } state_t;

    state_t state, next_state;
    reg [1:0] shift_counter;

    // State transition
    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_counter <= 2'b00;
        end else begin
            state <= next_state;
            if (state == SHIFTING && shift_ena) begin
                shift_counter <= shift_counter + 1;
            end
        end
    end

    // Next state logic
    always @* begin
        next_state = state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    next_state = PATTERN_DETECTED;
                end
            end
            PATTERN_DETECTED: begin
                if (data == 1'b1) begin
                    next_state = SHIFTING;
                    shift_counter = 2'b00;
                end else begin
                    next_state = IDLE;
                end
            end
            SHIFTING: begin
                shift_ena = 1'b1;
                if (shift_counter == 2'b11) begin
                    next_state = WAIT_COUNT;
                end
            end
            WAIT_COUNT: begin
                counting = 1'b1;
                if (done_counting) begin
                    next_state = DONE;
                end
            end
            DONE: begin
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE;
                end
            end
            default: next_state = IDLE;
        endcase
    end
endmodule
