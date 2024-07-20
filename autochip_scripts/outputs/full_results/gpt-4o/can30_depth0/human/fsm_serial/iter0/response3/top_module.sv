module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State Encoding
    typedef enum logic [2:0] {
        IDLE       = 3'b000,
        START_BIT  = 3'b001,
        DATA_BITS  = 3'b010,
        STOP_BIT   = 3'b011,
        ERROR      = 3'b100
    } state_t;
    
    state_t current_state, next_state;
    reg [2:0] bit_count;
    reg [7:0] data;

    // State Transition Logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 0;
            done <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next State Logic and Output Logic
    always_comb begin
        // Default values
        next_state = current_state;
        done = 0;

        case (current_state)
            IDLE: begin
                if (in == 0) // Start bit detected
                    next_state = START_BIT;
            end

            START_BIT: begin
                next_state = DATA_BITS;
                bit_count = 0;
            end

            DATA_BITS: begin
                bit_count = bit_count + 1;
                data[bit_count] = in; // Collecting data bits

                if (bit_count == 7) // All 8 data bits are collected
                    next_state = STOP_BIT;
            end

            STOP_BIT: begin
                if (in == 1) begin // Valid stop bit detected
                    done = 1;
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end

            ERROR: begin
                if (in == 1) // Wait for line to be idle (stop bit detected)
                    next_state = IDLE;
            end

            default: next_state = IDLE;
        endcase
    end
endmodule
