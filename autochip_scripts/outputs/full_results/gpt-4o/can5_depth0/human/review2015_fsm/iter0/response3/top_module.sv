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
        IDLE,      // Waiting for 1101 pattern
        DETECT1,   // Detected 1
        DETECT11,  // Detected 11
        DETECT110, // Detected 110
        DETECT1101,// Detected 1101
        SHIFT,     // Shifting in 4 bits for duration
        COUNT,     // Counting delay period
        DONE       // Notify user and wait for acknowledgement
    } state_t;
    
    state_t state, next_state;
    
    reg [2:0] shift_count;
    
    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (state)
            IDLE: begin
                if (data == 1'b1)
                    next_state = DETECT1;
            end
            DETECT1: begin
                if (data == 1'b1)
                    next_state = DETECT11;
                else
                    next_state = IDLE;
            end
            DETECT11: begin
                if (data == 1'b0)
                    next_state = DETECT110;
                else
                    next_state = IDLE;
            end
            DETECT110: begin
                if (data == 1'b1)
                    next_state = DETECT1101;
                else
                    next_state = IDLE;
            end
            DETECT1101: begin
                shift_ena = 1'b1;
                if (shift_count == 3'd3) // Shift in 4 bits
                    next_state = SHIFT;
            end
            SHIFT: begin
                shift_ena = 1'b1;
                shift_count = shift_count + 1'b1;
                if (shift_count == 3'd4) begin
                    next_state = COUNT;
                end
            end
            COUNT: begin
                counting = 1'b1;
                if (done_counting)
                    next_state = DONE;
            end
            DONE: begin
                done = 1'b1;
                if (ack)
                    next_state = IDLE;
            end
        endcase
    end

    // Shift count register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_count <= 3'd0;
        end else if (shift_ena) begin
            shift_count <= shift_count + 1'b1;
        end else if (state == DONE && ack) begin
            shift_count <= 3'd0;
        end
    end

endmodule
