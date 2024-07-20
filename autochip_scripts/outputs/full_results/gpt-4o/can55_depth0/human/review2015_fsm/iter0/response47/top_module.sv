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
    typedef enum logic [2:0] {
        IDLE        = 3'b000,
        DETECT_1    = 3'b001,
        DETECT_11   = 3'b010,
        DETECT_110  = 3'b011,
        DETECT_1101 = 3'b100,
        SHIFT       = 3'b101,
        COUNT       = 3'b110,
        DONE        = 3'b111
    } state_t;

    state_t state, next_state;
    reg [2:0] shift_count;

    // State transition logic
    always @(*) begin
        next_state = state; // Default to current state
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        
        case(state)
            IDLE: begin
                if (data == 1'b1) next_state = DETECT_1;
            end
            DETECT_1: begin
                if (data == 1'b0) next_state = IDLE;
                else next_state = DETECT_11;
            end
            DETECT_11: begin
                if (data == 1'b0) next_state = DETECT_110;
                else next_state = IDLE;
            end
            DETECT_110: begin
                if (data == 1'b1) next_state = DETECT_1101;
                else next_state = IDLE;
            end
            DETECT_1101: begin
                if (data == 1'b0) next_state = SHIFT;
                else next_state = IDLE;
            end
            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_count == 4) next_state = COUNT;
            end
            COUNT: begin
                counting = 1'b1;
                if (done_counting) next_state = DONE;
            end
            DONE: begin
                done = 1'b1;
                if (ack) next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // State flip-flops
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= IDLE;
        else 
            state <= next_state;
    end

    // Shift count logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            shift_count <= 3'd0;
        else if (state == SHIFT)
            shift_count <= shift_count + 1'b1;
        else
            shift_count <= 3'd0;
    end

endmodule
