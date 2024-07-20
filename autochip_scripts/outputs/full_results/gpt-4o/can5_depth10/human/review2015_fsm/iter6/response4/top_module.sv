module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack);

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        DETECT_1 = 3'b001,
        DETECT_11 = 3'b010,
        DETECT_110 = 3'b011,
        DETECT_1101 = 3'b100,
        SHIFT = 3'b101,
        WAIT_COUNT = 3'b110,
        DONE = 3'b111
    } state_t;

    state_t current_state, next_state;
    reg [1:0] shift_counter;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            shift_counter <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == SHIFT)
                shift_counter <= shift_counter + 1;
            else
                shift_counter <= 2'b00;
        end
    end

    always_comb begin
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        next_state = current_state;

        case (current_state)
            IDLE: begin
                if (data == 1'b1)
                    next_state = DETECT_1;
            end
            DETECT_1: begin
                if (data == 1'b1)
                    next_state = DETECT_11;
                else
                    next_state = IDLE;
            end
            DETECT_11: begin
                if (data == 1'b0)
                    next_state = DETECT_110;
                else
                    next_state = IDLE;
            end
            DETECT_110: begin
                if (data == 1'b1)
                    next_state = DETECT_1101;
                else
                    next_state = IDLE;
            end
            DETECT_1101: begin
                shift_ena = 1'b1;
                next_state = SHIFT;
            end
            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_counter == 2'b11)
                    next_state = WAIT_COUNT;
            end
            WAIT_COUNT: begin
                counting = 1'b1;
                if (done_counting)
                    next_state = DONE;
            end
            DONE: begin
                done = 1'b1;
                if (ack)
                    next_state = IDLE;
            end
        endcase
    end
endmodule
