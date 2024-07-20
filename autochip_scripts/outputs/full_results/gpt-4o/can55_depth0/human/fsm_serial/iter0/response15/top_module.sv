module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);
    // State encoding
    typedef enum logic[2:0] {
        IDLE,          // Idle state, waiting for start bit
        START_BIT,     // Detect start bit (0)
        DATA_BITS,     // Collecting 8 data bits
        STOP_BIT,      // Checking stop bit (1)
        ERROR          // Error state if stop bit is incorrect
    } state_t;

    state_t current_state, next_state;
    reg [2:0] bit_counter; // Counter to keep track of the number of data bits received
    reg [7:0] data_byte;   // Register to store the received data byte

    // State transition logic (sequential)
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_counter <= 3'b000;
            data_byte <= 8'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic (combinational)
    always_comb begin
        // Default values
        next_state = current_state;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (in == 1'b0) // Start bit detected
                    next_state = START_BIT;
            end

            START_BIT: begin
                next_state = DATA_BITS;
                bit_counter = 3'b000;
            end

            DATA_BITS: begin
                if (bit_counter < 3'b111) begin
                    next_state = DATA_BITS; // Continue collecting data bits
                end else begin
                    next_state = STOP_BIT; // All 8 data bits collected
                end
                data_byte[bit_counter] = in;
                bit_counter = bit_counter + 1;
            end

            STOP_BIT: begin
                if (in == 1'b1) begin
                    done = 1'b1; // Stop bit is correct, byte received successfully
                    next_state = IDLE;
                end else begin
                    next_state = ERROR; // Stop bit is incorrect
                end
            end
            
            ERROR: begin
                if (in == 1'b1) // Wait until the line goes back to idle (logic 1)
                    next_state = IDLE;
            end
        endcase
    end
endmodule
