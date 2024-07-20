module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        PATTERN_DETECT = 3'b001,
        SHIFT = 3'b010,
        COUNT_WAIT = 3'b011,
        DONE = 3'b100
    } state_t;

    state_t state, next_state;
    reg [3:0] data_shift;  // Shift register for pattern detection
    reg [2:0] shift_counter; // Counter to count 4 clock cycles during SHIFT state

    // Shift register logic for pattern detection
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            data_shift <= 4'b0000;
        end else if (state == IDLE || state == PATTERN_DETECT) begin
            data_shift <= {data_shift[2:0], data};
        end
    end

    // State transitions
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_counter <= 3'b000;
        end else begin
            state <= next_state;
            if (state == SHIFT) begin
                shift_counter <= shift_counter + 1;
            end else begin
                shift_counter <= 3'b000;
            end
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (data_shift == 4'b1101) begin
                    next_state = PATTERN_DETECT;
                end else begin
                    next_state = IDLE;
                end
            end
            PATTERN_DETECT: begin
                next_state = SHIFT;
            end
            SHIFT: begin
                if (shift_counter == 3'b100) begin
                    next_state = COUNT_WAIT;
                end else begin
                    next_state = SHIFT;
                end
            end
            COUNT_WAIT: begin
                if (done_counting) begin
                    next_state = DONE;
                end else begin
                    next_state = COUNT_WAIT;
                end
            end
            DONE: begin
                if (ack) begin
                    next_state = IDLE;
                end else begin
                    next_state = DONE;
                end
            end
        endcase
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            shift_ena <= (state == SHIFT);
            counting <= (state == COUNT_WAIT);
            done <= (state == DONE);
        end
    end
endmodule
