module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // FSM states
    typedef enum logic [2:0] {
        IDLE,        // Idle state, waiting for start bit
        START_BIT,   // Detected start bit
        DATA_BITS,   // Receiving data bits
        STOP_BIT,    // Verifying stop bit
        ERROR_BIT    // Error state, waiting for line to be idle
    } state_t;

    state_t current_state, next_state;
    reg [2:0] bit_count; // Bit counter for data bits
    reg [7:0] data;      // Data register to store received bits
    
    // State transition logic (sequential)
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 0;
            done <= 0;
        end else begin
            current_state <= next_state;
        end
    end
    
    // Next state logic and output logic (combinational)
    always_comb begin
        next_state = current_state;
        done = 0;

        case (current_state)
            IDLE: begin
                if (in == 0)  // Start bit detected
                    next_state = START_BIT;
            end

            START_BIT: begin
                next_state = DATA_BITS;
                bit_count = 0;
            end

            DATA_BITS: begin
                if (bit_count == 7) begin
                    next_state = STOP_BIT;
                end else begin
                    bit_count = bit_count + 1;
                end
            end

            STOP_BIT: begin
                if (in == 1) begin  // Stop bit correctly detected
                    done = 1;
                    next_state = IDLE;
                end else begin
                    next_state = ERROR_BIT;
                end
            end

            ERROR_BIT: begin
                if (in == 1)  // Waiting for line to return to idle
                    next_state = IDLE;
            end

            default: next_state = IDLE;
        endcase
    end

    // Data register logic (sequential)
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            data <= 0;
        end else if (current_state == DATA_BITS) begin
            data[bit_count] <= in;
        end
    end
endmodule
