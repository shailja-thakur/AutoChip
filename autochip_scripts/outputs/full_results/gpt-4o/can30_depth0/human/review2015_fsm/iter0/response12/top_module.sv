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

    // State declarations
    typedef enum reg [2:0] {
        IDLE,
        DETECT_1,
        DETECT_11,
        DETECT_110,
        DETECT_1101,
        SHIFT,
        COUNT,
        DONE
    } state_t;
    
    state_t state, next_state;
    reg [2:0] shift_counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_counter <= 3'b000;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            state <= next_state;
            if (state == SHIFT) begin
                shift_counter <= shift_counter + 1;
            end else if (state != DETECT_1101) begin
                shift_counter <= 3'b000;
            end
        end
    end

    always @(*) begin
        // Default values for outputs
        shift_ena = 0;
        counting = 0;
        done = 0;

        case (state)
            IDLE: begin
                if (data) next_state = DETECT_1;
                else next_state = IDLE;
            end

            DETECT_1: begin
                if (data) next_state = DETECT_11;
                else next_state = IDLE;
            end

            DETECT_11: begin
                if (!data) next_state = DETECT_110;
                else next_state = IDLE;
            end

            DETECT_110: begin
                if (data) next_state = DETECT_1101;
                else next_state = IDLE;
            end

            DETECT_1101: begin
                if (data) next_state = DETECT_1; // Possible overlapping sequence
                else next_state = SHIFT;
            end

            SHIFT: begin
                shift_ena = 1;
                if (shift_counter == 3'b011) next_state = COUNT;
                else next_state = SHIFT;
            end

            COUNT: begin
                counting = 1;
                if (done_counting) next_state = DONE;
                else next_state = COUNT;
            end

            DONE: begin
                done = 1;
                if (ack) next_state = IDLE;
                else next_state = DONE;
            end

            default: next_state = IDLE;
        endcase
    end

endmodule
