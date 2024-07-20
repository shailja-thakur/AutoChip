module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // Define states
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        START = 2'b01,
        RECEIVE = 2'b10,
        STOP = 2'b11
    } state_t;

    state_t current_state, next_state;
    reg [3:0] bit_count; // Increased width to count up to 10 bits (start, 8 data, stop)
    reg start_detected;

    // State Transition Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 4'b0000;
            done <= 0;
            start_detected <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next State Logic
    always @(*) begin
        next_state = current_state;
        done = 0;
        case (current_state)
            IDLE: begin
                if (~in) // 'in' detected 0 (start bit)
                    next_state = START;
            end
            START: begin
                if (bit_count == 4'b0001)
                    next_state = RECEIVE;
            end
            RECEIVE: begin
                if (bit_count == 4'd9)
                    next_state = STOP;
            end
            STOP: begin
                if (in) // 'in' detected 1 (stop bit)
                    next_state = IDLE;
            end
        endcase
    end

    // Bit Count Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_count <= 4'b0000;
            start_detected <= 0;
        end else if (current_state == START) begin
            bit_count <= bit_count + 1;
            start_detected <= 1;
        end else if (current_state == RECEIVE) begin
            bit_count <= bit_count + 1;
        end else if (current_state == STOP) begin
            bit_count <= 4'b0000;
        end else if (current_state == IDLE) begin
            bit_count <= 4'b0000;
            start_detected <= 0;
        end
    end

    // Done Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            done <= 0;
        end else if (current_state == STOP && in && start_detected) begin
            done <= 1;
        end else begin
            done <= 0;
        end
    end

endmodule
