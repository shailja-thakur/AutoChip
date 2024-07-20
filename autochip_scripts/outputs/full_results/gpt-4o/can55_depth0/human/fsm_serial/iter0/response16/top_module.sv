module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State declaration
    typedef enum reg [2:0] {
        IDLE,       // Wait for start bit
        START_BIT,  // Start bit detected
        DATA_BITS,  // Receiving 8 data bits
        STOP_BIT,   // Receiving stop bit
        DONE        // Byte successfully received
    } state_t;
    
    state_t state, next_state;
    reg [2:0] bit_count; // To count 8 data bits
    
    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'b0;
        end else begin
            state <= next_state;
            if (next_state == DATA_BITS)
                bit_count <= bit_count + 1;
            else if (next_state != state)
                bit_count <= 3'b0;
        end
    end
    
    // Next state logic
    always @(*) begin
        done = 0;
        case (state)
            IDLE: begin
                if (in == 0) // Start bit detected
                    next_state = START_BIT;
                else
                    next_state = IDLE;
            end
            START_BIT: begin
                next_state = DATA_BITS;
            end
            DATA_BITS: begin
                if (bit_count == 3'd7)
                    next_state = STOP_BIT;
                else
                    next_state = DATA_BITS;
            end
            STOP_BIT: begin
                if (in == 1) begin // Stop bit detected
                    done = 1;
                    next_state = DONE;
                end else begin
                    next_state = IDLE; // Incorrect stop bit, wait for new start bit
                end
            end
            DONE: begin
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end
    
endmodule
