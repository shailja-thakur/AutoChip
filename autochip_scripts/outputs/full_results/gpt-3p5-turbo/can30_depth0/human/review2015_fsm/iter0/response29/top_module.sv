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
        START,
        PATTERN_FOUND,
        SHIFT_ENA,
        COUNTING,
        DONE,
        WAIT_ACK
    } fsm_state_t;

    // Declare state and next_state variables
    reg fsm_state_t state, next_state;

    // Declare register to store the data received
    reg [3:0] pattern;

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= START;
            pattern <= 4'b0;
        end
        else begin
            state <= next_state;
            pattern <= {pattern[2:0], data};
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            START:
                if (pattern == 4'b1101)
                    next_state = PATTERN_FOUND;
                else
                    next_state = START;
                
            PATTERN_FOUND:
                next_state = SHIFT_ENA;
                
            SHIFT_ENA:
                if (shift_ena)
                    next_state = COUNTING;
                else
                    next_state = SHIFT_ENA;
                
            COUNTING:
                if (done_counting)
                    next_state = DONE;
                else
                    next_state = COUNTING;
                
            DONE:
                if (ack)
                    next_state = WAIT_ACK;
                else
                    next_state = DONE;
                
            WAIT_ACK:
                next_state = START;

            default:
                next_state = START;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end
        else begin
            case (state)
                START:
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                    done <= 1'b0;
                    
                PATTERN_FOUND:
                    shift_ena <= 1'b1;
                    counting <= 1'b0;
                    done <= 1'b0;
                    
                SHIFT_ENA:
                    shift_ena <= 1'b1;
                    counting <= 1'b0;
                    done <= 1'b0;
                    
                COUNTING:
                    shift_ena <= 1'b0;
                    counting <= 1'b1;
                    done <= 1'b0;
                    
                DONE:
                    shift_ena <= 1'b0;
                    counting <= 1'b1;
                    done <= 1'b1;
                    
                WAIT_ACK:
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                    done <= 1'b1;
            endcase
        end
    end
endmodule
