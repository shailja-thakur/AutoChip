module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State enumeration
    typedef enum logic [2:0] {
        IDLE,       // Waiting for start bit
        START,      // Start bit detected
        DATA,       // Receiving data bits
        STOP,       // Ready for stop bit
        ERROR       // Stop bit missing or incorrect
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count; // To count data bits received
    reg [7:0] data;      // To store the received byte

    // FSM state transitions
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and output
    always_comb begin
        // Default assignments
        next_state = state;
        done = 1'b0;

        case (state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected (logic low)
                    next_state = START;
                end
            end

            START: begin
                next_state = DATA;
                bit_count = 3'd0;
            end

            DATA: begin
                if (bit_count == 3'd7) begin // Received all 8 data bits
                    next_state = STOP;
                end else begin
                    bit_count = bit_count + 1;
                end
            end

            STOP: begin
                if (in == 1'b1) begin // Correct stop bit (logic high)
                    next_state = IDLE;
                    done = 1'b1; // Signal done when stop bit is correct
                end else begin // Incorrect stop bit
                    next_state = ERROR;
                end
            end

            ERROR: begin
                if (in == 1'b1) begin // Wait for line to be idle (stop bit)
                    next_state = IDLE;
                end
            end

            default: begin
                next_state = IDLE; // Default to handle unexpected behavior
            end
        endcase
    end

    // No further actions needed here; simple FSM

endmodule
