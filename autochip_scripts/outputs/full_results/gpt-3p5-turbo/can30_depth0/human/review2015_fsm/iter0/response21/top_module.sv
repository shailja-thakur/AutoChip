module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // Define state enum
    typedef enum logic [2:0] {
        WAIT_FOR_START,
        SHIFT_IN,
        WAIT_FOR_COUNTING,
        TIMER_DONE,
        WAIT_FOR_ACK
    } state_type;

    // Define state register
    reg state_type state, next_state;

    // Define start sequence
    parameter START_SEQ = 3'b110;

    // Register for start sequence detection
    reg [2:0] seq_reg;
    
    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= WAIT_FOR_START;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        // Default next state
        next_state = state;
        shift_ena = 0;
        counting = 0;
        done = 0;

        case (state)
            WAIT_FOR_START: begin
                seq_reg = {seq_reg[1:0], data};
                if (seq_reg == START_SEQ) begin
                    next_state = SHIFT_IN;
                    shift_ena = 1;
                end
            end

            SHIFT_IN: begin
                shift_ena = 1;
                next_state = WAIT_FOR_COUNTING;
            end

            WAIT_FOR_COUNTING: begin
                counting = 1;
                if (done_counting) begin
                    next_state = TIMER_DONE;
                    done = 1;
                end
            end

            TIMER_DONE: begin
                if (ack) begin
                    next_state = WAIT_FOR_START;
                end
            end

            WAIT_FOR_ACK: begin
                if (ack) begin
                    next_state = WAIT_FOR_START;
                end
            end
        endcase
    end
endmodule
