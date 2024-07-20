module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // States definition
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        CHECK_STOP = 3'b011,
        ERROR = 3'b100
    } state_t;
    
    state_t state, next_state;
    reg [2:0] bit_index;  // Used to count the 8 bits of data
    reg [7:0] data_byte;  // Used to store received data bits
    
    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // State machine
    always @(*) begin
        next_state = state; // Default to stay in the current state
        done = 1'b0;

        case (state)
            IDLE: begin
                if (in == 1'b0) // Start bit detected
                    next_state = START;
            end

            START: begin
                next_state = DATA; // Move to data collection state
                bit_index = 3'b0; // Reset bit counter
            end

            DATA: begin
                data_byte[bit_index] = in; // Collect data bits
                if (bit_index == 3'b111) // If all 8 bits are collected
                    next_state = CHECK_STOP;
                else
                    bit_index = bit_index + 1'b1; // Increment bit index
            end

            CHECK_STOP: begin
                if (in == 1'b1) begin // Stop bit must be 1
                    done = 1'b1; // Byte received successfully
                    next_state = IDLE;
                end else begin
                    next_state = ERROR; // Stop bit error
                end
            end

            ERROR: begin
                if (in == 1'b1) // Wait for the line to go idle (1)
                    next_state = IDLE;
            end
        endcase
    end

endmodule
