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
        IDLE = 3'b000,
        DETECT_1 = 3'b001,
        DETECT_11 = 3'b010,
        DETECT_110 = 3'b011,
        DETECT_1101 = 3'b100,
        SHIFT_4BITS = 3'b101,
        WAIT_COUNTER = 3'b110,
        DONE_WAIT_ACK = 3'b111
    } state_t;
    
    state_t state, next_state;
    reg [2:0] shift_cycle_count;
    
    // State Transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_cycle_count <= 3'b000;
        end
        else begin
            state <= next_state;
            if (state == SHIFT_4BITS)
                shift_cycle_count <= shift_cycle_count + 1;
            else
                shift_cycle_count <= 3'b000;
        end
    end
    
    // Next state logic
    always @(*) begin
        // Default outputs
        shift_ena = 0;
        counting = 0;
        done = 0;

        case (state)
            IDLE: begin
                if (data)
                    next_state = DETECT_1;
                else
                    next_state = IDLE;
            end
            DETECT_1: begin
                if (data)
                    next_state = DETECT_11;
                else
                    next_state = IDLE;
            end
            DETECT_11: begin
                if (data)
                    next_state = DETECT_110;
                else
                    next_state = IDLE;
            end
            DETECT_110: begin
                if (data)
                    next_state = DETECT_1101;
                else
                    next_state = IDLE;
            end
            DETECT_1101: begin
                if (data)
                    next_state = SHIFT_4BITS;
                else
                    next_state = IDLE;
            end
            SHIFT_4BITS: begin
                shift_ena = 1;
                if (shift_cycle_count == 3)
                    next_state = WAIT_COUNTER;
                else
                    next_state = SHIFT_4BITS;
            end
            WAIT_COUNTER: begin
                counting = 1;
                if (done_counting)
                    next_state = DONE_WAIT_ACK;
                else
                    next_state = WAIT_COUNTER;
            end
            DONE_WAIT_ACK: begin
                done = 1;
                if (ack) 
                    next_state = IDLE;
                else
                    next_state = DONE_WAIT_ACK;
            end
            default: next_state = IDLE;
        endcase
    end
endmodule
