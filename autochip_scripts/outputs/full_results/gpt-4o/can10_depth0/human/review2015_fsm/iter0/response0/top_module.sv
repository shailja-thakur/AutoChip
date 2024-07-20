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

    // FSM state definitions
    typedef enum logic [2:0] {
        IDLE       = 3'd0,
        DETECT_1   = 3'd1,
        DETECT_11  = 3'd2,
        DETECT_110 = 3'd3,
        DETECT_1101 = 3'd4,
        SHIFT      = 3'd5,
        COUNT      = 3'd6,
        DONE       = 3'd7
    } state_t;
    
    state_t state, next_state;
    reg [2:0] shift_cycles;  // to count 4 shift cycles

    // State register
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                if (data == 1'b1)
                    next_state = DETECT_1;
            end
            DETECT_1: begin
                if (data == 1'b1)
                    next_state = DETECT_11;
                else
                    next_state = IDLE;
            end
            DETECT_11: begin
                if (data == 1'b0)
                    next_state = DETECT_110;
                else
                    next_state = IDLE;
            end
            DETECT_110: begin
                if (data == 1'b1)
                    next_state = DETECT_1101;
                else
                    next_state = IDLE;
            end
            DETECT_1101: begin
                next_state = SHIFT;
            end
            SHIFT: begin
                if (shift_cycles == 3)  // completed 4 cycles, 0 to 3
                    next_state = COUNT;
            end
            COUNT: begin
                if (done_counting)
                    next_state = DONE;
            end
            DONE: begin
                if (ack)
                    next_state = IDLE;
            end
        endcase
    end

    // Output logic and shift cycle counter
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
            shift_cycles <= 3'd0;
        end
        else begin
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
            case (state)
                SHIFT: begin
                    shift_ena <= 1'b1;
                    shift_cycles <= shift_cycles + 1;
                end
                COUNT: begin
                    counting <= 1'b1;
                    shift_cycles <= 3'd0;  // reset shift cycle counter
                end
                DONE: begin
                    done <= 1'b1;
                end
            endcase
        end
    end

endmodule
