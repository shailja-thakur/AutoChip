module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State declaration
    typedef enum logic [2:0] {
        IDLE,        // Waiting for the start bit (0)
        START,       // Start bit detected
        DATA,        // Receiving data bits
        STOP,        // Stop bit detection
        ERROR        // Error state if stop bit fails
    } state_t;
    
    state_t state, next_state;
    reg [2:0] bit_position;  // To keep track of received bits
    reg [7:0] data;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            out_byte <= 8'b0;
            done <= 0;
            bit_position <= 0;
            data <= 8'b0;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        next_state = state;  // Default to holding state
        done = 0;
        
        case (state)
            IDLE: begin
                if (in == 0) // Start bit detected
                    next_state = START;
            end
            START: begin
                if (in == 0) begin // Confirm start bit (should be zero)
                    next_state = DATA;
                    bit_position = 0;
                end else begin
                    next_state = IDLE; // False start, back to idle
                end
            end
            DATA: begin
                if (bit_position < 8) begin
                    data[bit_position] = in; // Store incoming data bits
                    bit_position = bit_position + 1;
                end else begin
                    next_state = STOP; // All data bits received, now check stop bit
                end
            end
            STOP: begin
                if (in == 1) begin // Stop bit should be 1
                    out_byte = data; // Data is valid
                    done = 1;
                    next_state = IDLE; // Go back to waiting for the next byte
                end else begin
                    next_state = ERROR; // Stop bit error, go to error state
                end
            end
            ERROR: begin
                if (in == 1) begin // Wait for stop bit to return to idle
                    next_state = IDLE;
                end else begin
                    next_state = ERROR; // Remain in error state until idle
                end
            end
        endcase
    end
endmodule
