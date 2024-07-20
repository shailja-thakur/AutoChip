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
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        DETECT1 = 3'b001,
        DETECT2 = 3'b010,
        DETECT3 = 3'b011,
        DETECT4 = 3'b100,
        SHIFT = 3'b101,
        WAIT_COUNT = 3'b110,
        DONE = 3'b111
    } state_t;

    state_t current_state, next_state;

    // Counter for shifting bits
    reg [1:0] shift_counter;

    // State register
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and outputs
    always_comb begin
        // Default values
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        next_state = current_state;

        case(current_state)
            IDLE: begin
                if (data == 1'b1) next_state = DETECT1;
            end
            DETECT1: begin
                if (data == 1'b1) next_state = DETECT2;
                else next_state = IDLE;
            end
            DETECT2: begin
                if (data == 1'b0) next_state = DETECT3;
                else next_state = IDLE;
            end
            DETECT3: begin
                if (data == 1'b1) next_state = DETECT4;
                else next_state = IDLE;
            end
            DETECT4: begin
                if (data == 1'b1) next_state = DETECT4;
                else if (data == 1'b0) next_state = SHIFT;
                else next_state = IDLE;
            end
            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_counter == 3'd3) begin
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
        endcase
    end

    // Shift counter logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_counter <= 2'b00;
        end else if (current_state == SHIFT) begin
            shift_counter <= shift_counter + 1;
        end else begin
            shift_counter <= 2'b00;
        end
    end
endmodule
