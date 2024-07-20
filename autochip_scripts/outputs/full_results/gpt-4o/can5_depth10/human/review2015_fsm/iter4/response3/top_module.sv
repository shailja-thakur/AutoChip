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
        DETECT_1 = 3'b001,
        DETECT_11 = 3'b010,
        DETECT_110 = 3'b011,
        SHIFT = 3'b100,
        WAIT_COUNT = 3'b101,
        DONE = 3'b110
    } state_t;

    state_t current_state, next_state;

    // Counter for shifting bits
    reg [2:0] shift_counter;

    // State register
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        // Default values
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        next_state = current_state;

        case(current_state)
            IDLE: begin
                if (data == 1) begin
                    next_state = DETECT_1;
                end
            end
            DETECT_1: begin
                if (data == 1) begin
                    next_state = DETECT_11;
                end else begin
                    next_state = IDLE;
                end
            end
            DETECT_11: begin
                if (data == 0) begin
                    next_state = DETECT_110;
                end else begin
                    next_state = IDLE;
                end
            end
            DETECT_110: begin
                if (data == 1) begin
                    next_state = SHIFT;
                end else begin
                    next_state = IDLE;
                end
            end
            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_counter == 3'h3) begin
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
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Shift counter logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_counter <= 3'b0;
        end else if (current_state == SHIFT) begin
            shift_counter <= shift_counter + 1;
        end else if (current_state != SHIFT) begin
            shift_counter <= 3'b0;
        end
    end
endmodule
