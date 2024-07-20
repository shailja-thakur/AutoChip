module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State declaration
    typedef enum logic [2:0] {
        IDLE      = 3'b000,
        START_BIT = 3'b001,
        DATA_BITS = 3'b010,
        STOP_BIT  = 3'b011,
        WAIT_STOP = 3'b100
    } state_t;
    state_t state, next_state;

    reg [2:0] bit_counter; // Counter for data bits
    reg [7:0] data;        // Temporarily holds data bits

    // Synchronous state and data bits updates
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            data <= 8'b0;
            bit_counter <= 3'b0;
            out_byte <= 8'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (state == DATA_BITS) begin
                data[bit_counter] <= in;
                bit_counter <= bit_counter + 1'b1;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;
        done = 1'b0;
        case (state)
            IDLE: begin
                if (in == 1'b0) begin // Detect start bit
                    next_state = START_BIT;
                end
            end
            START_BIT: begin
                next_state = DATA_BITS;
                bit_counter = 3'b0;
            end
            DATA_BITS: begin
                if (bit_counter == 3'd7) begin // All data bits received
                    next_state = STOP_BIT;
                end
            end
            STOP_BIT: begin
                if (in == 1'b1) begin // Stop bit check
                    out_byte = data;
                    done = 1'b1;
                    next_state = IDLE;
                end else begin
                    next_state = WAIT_STOP;
                end
            end
            WAIT_STOP: begin
                if (in == 1'b1) begin // Wait for a valid stop bit
                    next_state = IDLE;
                end
            end
            default: next_state = IDLE;
        endcase
    end

endmodule
