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

    // State enumeration
    typedef enum reg [3:0] {
        IDLE,
        S1,
        S11,
        S110,
        S1101,
        SHIFT,
        COUNT,
        DONE
    } state_t;
    
    state_t state, next_state;
    reg [2:0] shift_counter;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_counter <= 0;
        end else begin
            state <= next_state;
            if (state == SHIFT) begin
                shift_counter <= shift_counter + 1;
            end else begin
                shift_counter <= 0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE:  next_state = (data) ? S1 : IDLE;
            S1:    next_state = (data) ? S11 : IDLE;
            S11:   next_state = (data) ? S11 : S110;
            S110:  next_state = (data) ? S1101 : IDLE;
            S1101: next_state = SHIFT;
            SHIFT: next_state = (shift_counter == 4) ? COUNT : SHIFT;
            COUNT: next_state = (done_counting) ? DONE : COUNT;
            DONE:  next_state = (ack) ? IDLE : DONE;
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            shift_ena <= (state == SHIFT);
            counting <= (state == COUNT);
            done <= (state == DONE);
        end
    end

endmodule
