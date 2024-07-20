module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // State encoding
    typedef enum reg [2:0] {
        IDLE, MATCH1, MATCH11, MATCH110, MATCH1101,
        SHIFT, COUNT, DONE
    } state_t;
    
    state_t state, next_state;
    reg [2:0] shift_count;
    
    // Next state logic
    always @(*) begin
        case(state)
            IDLE:        next_state = (data) ? MATCH1 : IDLE;
            MATCH1:      next_state = (data) ? MATCH11 : IDLE;
            MATCH11:     next_state = (~data) ? MATCH110 : IDLE;
            MATCH110:    next_state = (data) ? MATCH1101 : IDLE;
            MATCH1101:   next_state = (data) ? SHIFT : IDLE; // Pattern "1101" detected
            SHIFT:       next_state = (shift_count == 3) ? COUNT : SHIFT;
            COUNT:       next_state = (done_counting) ? DONE : COUNT;
            DONE:        next_state = (ack) ? IDLE : DONE;
            default:     next_state = IDLE; // Default state
        endcase
    end
    
    // Output logic and state transitions
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_count <= 0;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            state <= next_state;
            
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            
            case (state)
                IDLE, MATCH1, MATCH11, MATCH110, MATCH1101: begin
                    shift_count <= 0;
                end
                SHIFT: begin
                    shift_ena <= 1;
                    shift_count <= shift_count + 1;
                end
                COUNT: begin
                    counting <= 1;
                end
                DONE: begin
                    done <= 1;
                end
            endcase
        end
    end
    
endmodule
