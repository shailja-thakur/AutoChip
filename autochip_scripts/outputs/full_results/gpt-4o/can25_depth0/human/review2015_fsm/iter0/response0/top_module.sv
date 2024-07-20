module top_module(
	input clk,
	input reset,
	input data,
	output reg shift_ena,
	output reg counting,
	input done_counting,
	output reg done,
	input ack );

    // State definition
    typedef enum reg [2:0] {
        S_IDLE       = 3'b000, // Reset state, looking for 1101
        S_DETECT_1   = 3'b001, 
        S_DETECT_11  = 3'b010,
        S_DETECT_110 = 3'b011,
        S_SHIFT      = 3'b100, // Enable shifting for 4 cycles
        S_COUNT      = 3'b101, // Counting state, waiting for done_counting
        S_DONE       = 3'b110, // Notify user, waiting for ack
        S_WAIT_ACK   = 3'b111  // Wait for ack
    } state_type;
    
    state_type state, next_state;
    reg [2:0] shift_counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S_IDLE;
            shift_counter <= 3'b0;
        end else begin
            state <= next_state;
            if (state == S_SHIFT)
                shift_counter <= shift_counter + 1;
            else
                shift_counter <= 3'b0;
        end
    end

    always @(*) begin
        // Default values for outputs
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        next_state = state;

        case (state)
            S_IDLE: begin
                if (data) next_state = S_DETECT_1;
            end
            S_DETECT_1: begin
                if (data) next_state = S_DETECT_11;
                else next_state = S_IDLE;
            end
            S_DETECT_11: begin
                if (data) next_state = S_DETECT_110;
                else next_state = S_IDLE;
            end
            S_DETECT_110: begin
                if (~data) next_state = S_SHIFT;
                else next_state = S_IDLE;
            end
            S_SHIFT: begin
                shift_ena = 1'b1;
                if (shift_counter == 3'b100)
                    next_state = S_COUNT;
            end
            S_COUNT: begin
                counting = 1'b1;
                if (done_counting)
                    next_state = S_DONE;
            end
            S_DONE: begin
                done = 1'b1;
                if (ack)
                    next_state = S_IDLE;
            end
            default: next_state = S_IDLE;
        endcase
    end
endmodule
