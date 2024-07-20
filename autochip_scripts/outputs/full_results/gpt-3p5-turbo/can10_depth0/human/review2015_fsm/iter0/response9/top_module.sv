module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // Define the states of the finite-state machine
    typedef enum logic [2:0] {
        IDLE,
        DETECTING_PATTERN,
        WAITING_FOR_COUNTING,
        TIMED_OUT,
        WAITING_FOR_ACK
    } state_type;

    // Define the current state variable
    reg[state_type] current_state, next_state;

    // Define the registers for shift_ena, counting, and done outputs
    reg shift_ena_reg, counting_reg, done_reg;

    // Register for storing the input data
    reg [3:0] pattern_reg;

    always_ff @(posedge clk) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;

        case (current_state)
            IDLE:
                if (data == 4'b1101)
                    next_state = DETECTING_PATTERN;
                else
                    next_state = IDLE;
            DETECTING_PATTERN:
                begin
                    next_state = WAITING_FOR_COUNTING;
                    pattern_reg <= data[2:0];
                end
            WAITING_FOR_COUNTING:
                if (done_counting)
                    next_state = TIMED_OUT;
                else
                    next_state = WAITING_FOR_COUNTING;
            TIMED_OUT:
                next_state = WAITING_FOR_ACK;
            WAITING_FOR_ACK:
                if (ack)
                    next_state = IDLE;
                else
                    next_state = WAITING_FOR_ACK;
        endcase
    end

    always_ff @(posedge clk) begin
        case (current_state)
            IDLE:
                begin
                    shift_ena_reg <= 1'b0;
                    counting_reg <= 1'b0;
                    done_reg <= 1'b0;
                end
            DETECTING_PATTERN:
                begin
                    shift_ena_reg <= 1'b1;
                    counting_reg <= 1'b0;
                    done_reg <= 1'b0;
                end
            WAITING_FOR_COUNTING:
                begin
                    shift_ena_reg <= 1'b0;
                    counting_reg <= 1'b1;
                    done_reg <= 1'b0;
                end
            TIMED_OUT:
                begin
                    shift_ena_reg <= 1'b0;
                    counting_reg <= 1'b0;
                    done_reg <= 1'b1;
                end
            WAITING_FOR_ACK:
                begin
                    shift_ena_reg <= 1'b0;
                    counting_reg <= 1'b0;
                    done_reg <= 1'b0;
                end
        endcase
    end

    // Assign the output ports from the registered outputs
    assign shift_ena = shift_ena_reg;
    assign counting = counting_reg;
    assign done = done_reg;

endmodule
