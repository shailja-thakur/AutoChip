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
    typedef enum reg [2:0] {
        IDLE        = 3'b000,
        PATTERN_M1  = 3'b001,
        PATTERN_11  = 3'b010,
        PATTERN_110 = 3'b011,
        PATTERN_1101 = 3'b100,
        SHIFT       = 3'b101,
        COUNT       = 3'b110,
        DONE        = 3'b111
    } state_t;

    state_t state, next_state;
    reg [2:0] shift_counter;

    // State transition and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            shift_counter <= 0;
        end else begin
            state <= next_state;

            // Output logic
            case(state)
                IDLE: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                end
                SHIFT: if (shift_counter < 4) shift_counter <= shift_counter + 1;
                COUNT: if (done_counting) counting <= 0;
                DONE:  if (ack) done <= 0;
            endcase
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state; // Default to the same state

        case(state)
            IDLE: if (data == 1) next_state = PATTERN_M1;
            PATTERN_M1: if (data == 1) next_state = PATTERN_11; else next_state = IDLE;
            PATTERN_11: if (data == 0) next_state = PATTERN_110; else next_state = IDLE;
            PATTERN_110: if (data == 1) next_state = PATTERN_1101; else next_state = IDLE;
            PATTERN_1101: next_state = SHIFT;
            SHIFT: if (shift_counter == 4) next_state = COUNT;
            COUNT: if (done_counting) next_state = DONE;
            DONE:  if (ack) next_state = IDLE;
        endcase

        // Output control signals
        case(next_state)
            SHIFT: shift_ena = (shift_counter < 4);
            COUNT: counting = 1;
            DONE:  done = 1;
        endcase
    end
endmodule
