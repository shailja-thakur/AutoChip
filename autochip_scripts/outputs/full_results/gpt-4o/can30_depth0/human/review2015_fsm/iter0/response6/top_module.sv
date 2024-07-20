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

    // State enumerations
    typedef enum reg [2:0] {
        IDLE,
        SHIFT, 
        COUNT, 
        DONE, 
        WAIT_ACK
    } state_t;

    state_t state, next_state;
    reg [3:0] pattern;
    reg [2:0] shift_counter;

    // Sequential logic for state transitions
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Combinatorial logic for next state determination
    always @(*) begin
        case (state)
            IDLE: begin
                if (pattern == 4'b1101) next_state = SHIFT;
                else next_state = IDLE;
            end
            SHIFT: begin
                if (shift_counter == 3'd3) next_state = COUNT;
                else next_state = SHIFT;
            end
            COUNT: begin
                if (done_counting) next_state = DONE;
                else next_state = COUNT;
            end
            DONE: begin
                if (ack) next_state = IDLE;
                else next_state = WAIT_ACK;
            end
            WAIT_ACK: begin
                if (ack) next_state = IDLE;
                else next_state = WAIT_ACK;
            end
            default: next_state = IDLE;
        endcase
    end

    // Sequential logic for output and internal registers
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pattern <= 4'b0;
            shift_ena <= 0;
            shift_counter <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                    // Shift incoming bits into pattern register
                    pattern <= {pattern[2:0], data};
                end
                SHIFT: begin
                    shift_ena <= 1;
                    shift_counter <= shift_counter + 1;
                end
                COUNT: begin
                    shift_ena <= 0;
                    shift_counter <= 0;
                    counting <= 1;
                end
                DONE: begin
                    counting <= 0;
                    done <= 1;
                end
                WAIT_ACK: begin
                    // Stay in this state until ack is received
                end
                default: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                end
            endcase
        end
    end

endmodule
