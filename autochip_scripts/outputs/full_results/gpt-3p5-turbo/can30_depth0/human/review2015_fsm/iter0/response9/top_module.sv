module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // Define states
    typedef enum logic [2:0] {
        IDLE,
        DETECT_PATTERN,
        SHIFT_ENA,
        COUNTING,
        NOTIFY,
        WAIT_ACK
    } state_t;

    // Define signals
    reg [2:0] state;
    reg [3:0] counter;

    // Assign initial state
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Determine next state and outputs based on current state
    always_comb begin
        case (state)
            IDLE: begin
                if (data == 4'b1101) begin
                    next_state = DETECT_PATTERN;
                    shift_ena = 1;
                    counting = 0;
                    done = 0;
                end else begin
                    next_state = IDLE;
                    shift_ena = 0;
                    counting = 0;
                    done = 0;
                end
            end

            DETECT_PATTERN: begin
                next_state = SHIFT_ENA;
                shift_ena = 1;
                counting = 0;
                done = 0;
            end

            SHIFT_ENA: begin
                if (counter < 4) begin
                    next_state = SHIFT_ENA;
                    shift_ena = 1;
                    counting = 0;
                    done = 0;
                end else begin
                    next_state = COUNTING;
                    shift_ena = 0;
                    counting = 1;
                    done = 0;
                end
            end

            COUNTING: begin
                if (done_counting) begin
                    next_state = NOTIFY;
                    shift_ena = 0;
                    counting = 0;
                    done = 0;
                end else begin
                    next_state = COUNTING;
                    shift_ena = 0;
                    counting = 1;
                    done = 0;
                end
            end

            NOTIFY: begin
                next_state = WAIT_ACK;
                shift_ena = 0;
                counting = 0;
                done = 1;
            end

            WAIT_ACK: begin
                if (ack) begin
                    next_state = IDLE;
                    shift_ena = 0;
                    counting = 0;
                    done = 0;
                end else begin
                    next_state = WAIT_ACK;
                    shift_ena = 0;
                    counting = 0;
                    done = 1;
                end
            end

            default: begin
                next_state = IDLE;
                shift_ena = 0;
                counting = 0;
                done = 0;
            end
        endcase
    end

    // Increment counter on each clock cycle
    always @(posedge clk) begin
        if (state == COUNTING) begin
            counter <= counter + 1;
        end else begin
            counter <= 0;
        end
    end

endmodule
