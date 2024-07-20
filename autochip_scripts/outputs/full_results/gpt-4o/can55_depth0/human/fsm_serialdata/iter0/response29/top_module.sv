module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State declaration
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START_BIT = 3'b001,
        DATA_BITS = 3'b010,
        STOP_BIT = 3'b011,
        DONE = 3'b100
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count;
    reg [7:0] byte_buffer;

    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 0;
            byte_buffer <= 0;
            out_byte <= 0;
            done <= 0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;
        done = 0;
        case (state)
            IDLE: begin
                if (in == 1'b0) // Detect start bit
                    next_state = START_BIT;
            end
            START_BIT: begin
                next_state = DATA_BITS;
                bit_count = 0;
            end
            DATA_BITS: begin
                if (bit_count == 3'd7)
                    next_state = STOP_BIT;
                else
                    next_state = DATA_BITS;
            end
            STOP_BIT: begin
                if (in == 1'b1)
                    next_state = DONE;
                else
                    next_state = IDLE;
            end
            DONE: begin
                done = 1;
                next_state = IDLE;
            end
        endcase
    end

    // Data capturing and bit count increment
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            byte_buffer <= 0;
            bit_count <= 0;
        end else if (state == DATA_BITS) begin
            byte_buffer[bit_count] <= in; // Collect data bits LSB first
            bit_count <= bit_count + 1;
        end else if (state == DONE) begin
            out_byte <= byte_buffer;
        end
    end

endmodule
