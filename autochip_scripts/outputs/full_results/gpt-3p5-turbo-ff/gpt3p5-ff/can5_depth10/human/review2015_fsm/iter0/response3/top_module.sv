module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // Defining the states
    typedef enum logic [2:0] {
        IDLE,
        DETECT_PATTERN,
        SHIFT_ENA,
        COUNTING,
        FINISHED,
        WAIT_ACK
    } state_t;

    // Creating state and next_state registers
    reg state_t state;
    reg state_t next_state;

    // Assigning initial state
    initial
        state = IDLE;
      
    // Sequential logic
    always_ff @(posedge clk, posedge reset)
    begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Combinational logic
    always_comb
    begin
        // Initializing next_state to the current state
        next_state = state;

        case (state)
            // IDLE state
            IDLE:
                if (data == 4'b1101)
                    next_state = DETECT_PATTERN;
                else
                    next_state = IDLE;
              
            // DETECT_PATTERN state
            DETECT_PATTERN:
                next_state = SHIFT_ENA;
              
            // SHIFT_ENA state
            SHIFT_ENA:
                next_state = COUNTING;
              
            // COUNTING state
            COUNTING:
                if (done_counting)
                    next_state = FINISHED;
                else
                    next_state = COUNTING;
              
            // FINISHED state
            FINISHED:
                if (ack)
                    next_state = WAIT_ACK;
                else
                    next_state = FINISHED;
              
            // WAIT_ACK state
            WAIT_ACK:
                next_state = IDLE;
        endcase
    end

    // Output assignments
    always_comb
    begin
        case (state)
            // IDLE state
            IDLE:
                begin
                    shift_ena = 1'b0;
                    counting = 1'b0;
                    done = 1'b0;
                end
              
            // DETECT_PATTERN state
            DETECT_PATTERN:
                begin
                    shift_ena = 1'b1;
                    counting = 1'b0;
                    done = 1'b0;
                end
              
            // SHIFT_ENA state
            SHIFT_ENA:
                begin
                    shift_ena = 1'b1;
                    counting = 1'b0;
                    done = 1'b0;
                end
              
            // COUNTING state
            COUNTING:
                begin
                    shift_ena = 1'b0;
                    counting = 1'b1;
                    done = 1'b0;
                end
              
            // FINISHED state
            FINISHED:
                begin
                    shift_ena = 1'b0;
                    counting = 1'b0;
                    done = 1'b1;
                end
              
            // WAIT_ACK state
            WAIT_ACK:
                begin
                    shift_ena = 1'b0;
                    counting = 1'b0;
                    done = 1'b1;
                end
        endcase
    end

endmodule
