module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // State definitions
    typedef enum reg [2:0] {
        IDLE      = 3'b000,
        DETECT_1  = 3'b001,
        DETECT_11 = 3'b010,
        DETECT_110= 3'b011,
        DETECT_1101 = 3'b100,
        SHIFT     = 3'b101,
        COUNT     = 3'b110,
        DONE      = 3'b111
    } state_t;

    state_t state, next_state;
    integer shift_count;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        shift_ena = 0;
        counting = 0;
        done = 0;
        
        case (state)
            IDLE: begin
                if (data)
                    next_state = DETECT_1;
            end
            DETECT_1: begin
                if (data)
                    next_state = DETECT_11;
                else
                    next_state = IDLE;
            end
            DETECT_11: begin
                if (data)
                    next_state = DETECT_110;
                else
                    next_state = IDLE;
            end
            DETECT_110: begin
                if (data)
                    next_state = DETECT_1101;
                else
                    next_state = IDLE;
            end
            DETECT_1101: begin
                if (data) begin
                    next_state = SHIFT;
                    shift_count = 0;
                end
            end
            SHIFT: begin
                shift_ena = 1;
                if (shift_count == 3)
                    next_state = COUNT;
                else
                    shift_count = shift_count + 1;
            end
            COUNT: begin
                counting = 1;
                if (done_counting)
                    next_state = DONE;
            end
            DONE: begin
                done = 1;
                if (ack)
                    next_state = IDLE;
            end
        endcase
    end

endmodule
