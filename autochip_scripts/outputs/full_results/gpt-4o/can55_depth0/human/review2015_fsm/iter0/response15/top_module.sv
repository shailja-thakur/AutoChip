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
    typedef enum logic [2:0] {
        IDLE            = 3'b000,
        PATTERN_DETECT  = 3'b001,
        SHIFT           = 3'b010,
        COUNT           = 3'b011,
        DONE            = 3'b100,
        WAIT_ACK        = 3'b101
    } state_t;

    state_t state, next_state;

    // Pattern detection registers
    reg [3:0] pattern_shift_reg;

    // Sequential logic for state transitions
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state and output logic
    always_comb begin
        // Default outputs
        shift_ena = 0;
        counting = 0;
        done = 0;

        case (state)
            IDLE: begin
                if (data)
                    pattern_shift_reg = {pattern_shift_reg[2:0], data};
                else
                    pattern_shift_reg = {pattern_shift_reg[2:0], 1'b0};

                if (pattern_shift_reg == 4'b1101)
                    next_state = SHIFT;
                else
                    next_state = IDLE;
            end

            SHIFT: begin
                shift_ena = 1;
                if (pattern_shift_reg == 4'b1111) // Assuming a simple count of 4 shifts
                    next_state = COUNT;
                else
                    next_state = SHIFT;
            end

            COUNT: begin
                counting = 1;
                if (done_counting)
                    next_state = DONE;
                else
                    next_state = COUNT;
            end

            DONE: begin
                done = 1;
                next_state = WAIT_ACK;
            end

            WAIT_ACK: begin
                done = 1;
                if (ack)
                    next_state = IDLE;
                else
                    next_state = WAIT_ACK;
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end
    
endmodule
