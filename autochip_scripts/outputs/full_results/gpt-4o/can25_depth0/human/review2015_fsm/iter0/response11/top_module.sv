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

    // State encoding
    typedef enum reg [2:0] {
        IDLE           = 3'b000,
        PATTERN_DETECT = 3'b001,
        SHIFT          = 3'b010,
        COUNT          = 3'b011,
        DONE           = 3'b100
    } state_t;
    
    state_t state, next_state;

    // Pattern detector shift register
    reg [3:0] shift_reg;

    // Counter for shift_ena
    reg [2:0] shift_counter;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        // Default values
        next_state = state;
        shift_ena  = 0;
        counting   = 0;
        done       = 0;
        
        case (state)
            IDLE: begin
                if (shift_reg == 4'b1101)
                    next_state = PATTERN_DETECT;
            end
            PATTERN_DETECT: begin
                next_state = SHIFT;
            end
            SHIFT: begin
                shift_ena = 1;
                if (shift_counter == 3)
                    next_state = COUNT;
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

    // Shift register and counter logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 4'b0;
            shift_counter <= 0;
        end else begin
            if (state == IDLE) begin
                shift_reg <= {shift_reg[2:0], data};
            end
            if (state == SHIFT) begin
                shift_counter <= shift_counter + 1;
            end else if (state != PATTERN_DETECT) begin
                shift_counter <= 0;
            end
        end
    end
endmodule
