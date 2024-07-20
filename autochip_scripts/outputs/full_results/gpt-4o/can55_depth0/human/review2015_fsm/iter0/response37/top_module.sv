module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // State declaration
    typedef enum reg [2:0] {
        IDLE,
        PATTERN_DETECT,
        SHIFT,
        COUNT,
        NOTIFY
    } state_t;

    state_t state, next_state;
    reg [3:0] shift_count;

    // Pattern detection shift register
    reg [3:0] shift_reg;
    
    // State transition and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_reg <= 4'b0;
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
            shift_count <= 4'b0;
        end else begin
            state <= next_state;
            shift_reg <= {shift_reg[2:0], data};
            if (state == SHIFT)
                shift_count <= shift_count + 1;
            else
                shift_count <= 4'b0;
        end
    end

    // Next state logic
    always @(*) begin
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        case (state)
            IDLE: begin
                if (shift_reg == 4'b1101)
                    next_state = SHIFT;
                else
                    next_state = IDLE;
            end
            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_count == 4)
                    next_state = COUNT;
                else
                    next_state = SHIFT;
            end
            COUNT: begin
                counting = 1'b1;
                if (done_counting)
                    next_state = NOTIFY;
                else
                    next_state = COUNT;
            end
            NOTIFY: begin
                done = 1'b1;
                if (ack)
                    next_state = IDLE;
                else
                    next_state = NOTIFY;
            end
        endcase
    end

endmodule
