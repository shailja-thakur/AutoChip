module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );
    
    // FSM state encoding
    typedef enum reg [2:0] {
        IDLE           = 3'b000,
        PATTERN_DETECT = 3'b001,
        SHIFT          = 3'b010,
        WAIT_COUNTERS  = 3'b011,
        DONE           = 3'b100
    } state_t;
    
    state_t state, next_state;
    reg [2:0] bitcount;
    
    // Pattern detection variables
    reg [3:0] shift_reg;
    
    // On every clock edge
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            bitcount <= 0;
            shift_reg <= 4'b0000;
        end else begin
            state <= next_state;
            
            case (state)
                IDLE: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                    shift_reg <= 4'b0000;
                end
                PATTERN_DETECT: begin
                    shift_ena <= 0;
                    shift_reg <= {shift_reg[2:0], data};
                    if (shift_reg == 4'b1101) begin
                        next_state <= SHIFT;
                    end
                end
                SHIFT: begin
                    shift_ena <= 1;
                    bitcount <= bitcount + 1;
                    if (bitcount == 4) begin
                        shift_ena <= 0;
                        next_state <= WAIT_COUNTERS;
                    end
                end
                WAIT_COUNTERS: begin
                    counting <= 1;
                    if (done_counting) begin
                        counting <= 0;
                        done <= 1;
                        next_state <= DONE;
                    end
                end
                DONE: begin
                    if (ack) begin
                        done <= 0;
                        next_state <= IDLE;
                    end
                end
                default: next_state <= IDLE;
            endcase
        end
    end
    
    // Next state logic for FSM
    always @(*) begin
        case (state)
            IDLE: next_state = PATTERN_DETECT;
            PATTERN_DETECT: next_state = (shift_reg == 4'b1101) ? SHIFT : PATTERN_DETECT;
            SHIFT: next_state = (bitcount == 4) ? WAIT_COUNTERS : SHIFT;
            WAIT_COUNTERS: next_state = (done_counting) ? DONE : WAIT_COUNTERS;
            DONE: next_state = (ack) ? IDLE : DONE;
            default: next_state = IDLE;
        endcase
    end

endmodule
