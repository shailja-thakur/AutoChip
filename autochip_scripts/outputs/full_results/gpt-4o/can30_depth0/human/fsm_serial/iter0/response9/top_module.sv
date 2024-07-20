module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);
    // State definitions
    typedef enum reg [2:0] {
        IDLE = 3'd0,
        START_BIT = 3'd1,
        DATA_BITS = 3'd2,
        STOP_BIT = 3'd3
    } state_t;

    state_t current_state, next_state;
    reg [3:0] bit_counter; // 4-bit counter because we need to count up to 10 (1 start + 8 data + 1 stop)
    reg [7:0] data; // Temporary storage for incoming data bits

    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_counter <= 4'd0;
            data <= 8'd0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            case (next_state)
                START_BIT, DATA_BITS: bit_counter <= bit_counter + 1; // Increment counter in START_BIT and DATA_BITS states
                default: bit_counter <= 4'd0; // Reset counter in all other states
            endcase
            if (next_state == DATA_BITS && current_state == START_BIT) begin
                data <= 8'd0; // Clear data register if we are transitioning from START_BIT to DATA_BITS
            end else if (next_state == DATA_BITS) begin
                data <= {in, data[7:1]}; // Shift-left data bits
            end
            if (next_state == STOP_BIT && in == 1'b1 && bit_counter == 4'd8) begin
                done <= 1'b1; // Set done when STOP_BIT is detected at the right position
            end else if (current_state != next_state) begin
                done <= 1'b0; // Clear done if state changes
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START_BIT; // Transition to START_BIT on start bit detection
                end else begin
                    next_state = IDLE;
                end
            end
            START_BIT: begin
                if (bit_counter == 4'd1) begin
                    next_state = DATA_BITS; // Transition to DATA_BITS after recognizing start bit
                end else begin
                    next_state = START_BIT;
                end
            end
            DATA_BITS: begin
                if (bit_counter == 4'd9) begin
                    next_state = STOP_BIT; // Transition to STOP_BIT after receiving 8 data bits
                end else begin
                    next_state = DATA_BITS;
                end
            end
            STOP_BIT: begin
                if (in == 1'b1) begin
                    next_state = IDLE; // Transition to IDLE after stop bit
                end else begin
                    next_state = STOP_BIT; // Stay in STOP_BIT if in is not high
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule
