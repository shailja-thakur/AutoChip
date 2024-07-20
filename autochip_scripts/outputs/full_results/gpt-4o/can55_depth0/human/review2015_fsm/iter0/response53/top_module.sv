module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // State Encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        DETECT_1 = 3'b001,
        DETECT_11 = 3'b010,
        DETECT_110 = 3'b011,
        SHIFT = 3'b100,
        COUNT = 3'b101,
        DONE = 3'b110
    } state_t;
    
    state_t state, next_state;
    reg [2:0] shift_count; // To keep track of 4 clock cycles for shift_ena
    
    // FSM State Transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next State Logic
    always @(*) begin
        // Default assignments
        next_state = state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        
        case(state)
            IDLE: begin
                if (data == 1'b1) next_state = DETECT_1;
            end
            DETECT_1: begin
                if (data == 1'b1) next_state = DETECT_11;
                else next_state = IDLE;
            end
            DETECT_11: begin
                if (data == 1'b0) next_state = DETECT_110;
                else next_state = IDLE;
            end
            DETECT_110: begin
                if (data == 1'b1) next_state = SHIFT;
                else next_state = IDLE;
            end
            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_count == 3'b011) next_state = COUNT; // After 4 cycles
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

    // Shift Counter Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_count <= 3'b000;
        end else if (state == SHIFT) begin
            if (shift_count < 3'b011) 
                shift_count <= shift_count + 1;
            else 
                shift_count <= 3'b000;
        end else begin
            shift_count <= 3'b000;
        end
    end
endmodule
