module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State definitions
    typedef enum logic [2:0] {
        IDLE,       // waiting for start bit
        START,      // start bit detected
        DATA0,      // bit0 received
        DATA1,      // bit1 received
        DATA2,      // bit2 received
        DATA3,      // bit3 received
        DATA4,      // bit4 received
        DATA5,      // bit5 received
        DATA6,      // bit6 received
        DATA7,      // bit7 received
        STOP        // stop bit expected
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            IDLE:   next_state = (in == 0) ? START : IDLE;
            START:  next_state = (in == 1) ? IDLE : DATA0;
            DATA0:  next_state = DATA1;
            DATA1:  next_state = DATA2;
            DATA2:  next_state = DATA3;
            DATA3:  next_state = DATA4;
            DATA4:  next_state = DATA5;
            DATA5:  next_state = DATA6;
            DATA6:  next_state = DATA7;
            DATA7:  next_state = STOP;
            STOP:   next_state = (in == 1) ? IDLE : STOP;
            default: next_state = IDLE;
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            done <= 0;
        else if (state == STOP && in == 1)
            done <= 1;
        else
            done <= 0;
    end

endmodule
