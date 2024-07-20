module top_module(
	input clk,
	input reset,
	input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // Define state encoding
    typedef enum reg [2:0] {
        IDLE     = 3'b000,
        PATTERN1 = 3'b001,
        PATTERN2 = 3'b010,
        PATTERN3 = 3'b011,
        PATTERN4 = 3'b100,
        SHIFT    = 3'b101,
        WAIT_CNT = 3'b110,
        WAIT_ACK = 3'b111
    } state_t;
    
    state_t state, next_state;
    integer shift_counter;

    // State transition on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end
    
    // Next state logic and output logic
    always @(*) begin
        // Default outputs
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        next_state = state;

        case (state)
            IDLE: begin
                if (data) // Detect 1
                    next_state = PATTERN1;
            end
            PATTERN1: begin
                if (~data)
                    next_state = PATTERN2;
                else
                    next_state = IDLE;
            end
            PATTERN2: begin
                if (data)
                    next_state = PATTERN3;
                else
                    next_state = IDLE;
            end
            PATTERN3: begin
                if (data)
                    next_state = PATTERN4;
                else
                    next_state = IDLE;
            end
            PATTERN4: begin
                if (~data)
                    next_state = SHIFT;
                else
                    next_state = IDLE;
            end
            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_counter < 3)
                    shift_counter = shift_counter + 1;
                else
                    next_state = WAIT_CNT;
            end
            WAIT_CNT: begin
                counting = 1'b1;
                if (done_counting)
                    next_state = WAIT_ACK;
            end
            WAIT_ACK: begin
                done = 1'b1;
                if (ack)
                    next_state = IDLE;
            end
        endcase
    end

    // Shift counter logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            shift_counter <= 0;
        else if (state == SHIFT)
            shift_counter <= shift_counter + 1;
        else
            shift_counter <= 0;
    end
endmodule
