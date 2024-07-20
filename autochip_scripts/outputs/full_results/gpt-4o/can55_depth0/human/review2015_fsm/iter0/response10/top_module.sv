module top_module(
	input clk,
	input reset,
	input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // State declaration
    typedef enum logic [2:0] {
        IDLE,
        S1,
        S2,
        S3,
        PATTERN_DETECTED,
        SHIFT,
        COUNT,
        DONE
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count; // Counter for 4-bit shift

    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'b000;
        end
        else begin
            state <= next_state;
            if (next_state == SHIFT) begin
                bit_count <= bit_count + 1;
            end
            else if (state != SHIFT) begin
                bit_count <= 3'b000;
            end
        end
    end

    // Next state logic
    always_comb begin
        // Default values
        next_state = state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (state)
            IDLE: begin
                if (data == 1'b1) next_state = S1;
            end
            S1: begin
                if (data == 1'b1) next_state = S2;
                else next_state = IDLE;
            end
            S2: begin
                if (data == 1'b0) next_state = S3;
                else next_state = IDLE;
            end
            S3: begin
                if (data == 1'b1) next_state = PATTERN_DETECTED;
                else next_state = IDLE;
            end
            PATTERN_DETECTED: begin
                next_state = SHIFT;
            end
            SHIFT: begin
                shift_ena = 1'b1;
                if (bit_count == 3'b011) next_state = COUNT;
            end
            COUNT: begin
                counting = 1'b1;
                if (done_counting) next_state = DONE;
            end
            DONE: begin
                done = 1'b1;
                if (ack) next_state = IDLE;
            end
        endcase
    end

endmodule
