module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    typedef enum reg [2:0] {
        IDLE,         // Idle state, waiting for start bit
        START_BIT,    // Start bit detected, validating
        DATA_BITS,    // Receiving 8 data bits
        STOP_BIT,     // Verifying the stop bit
        ERROR         // Error state, wait for idle (stop) bit
    } state_t;

    // State registers
    state_t current_state, next_state;
    reg [3:0] bit_count; // To count up to 8 bits
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 4'd0;
            done <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == DATA_BITS || current_state == STOP_BIT) begin
                bit_count <= bit_count + 4'd1;
            end else begin
                bit_count <= 4'd0;
            end
        end
    end
    
    always @(*) begin
        // Default output
        next_state = current_state;
        done = 0;

        case (current_state)
            IDLE: begin
                if (in == 0) // Start bit detected
                    next_state = START_BIT;
            end
            
            START_BIT: begin
                next_state = DATA_BITS;
            end
            
            DATA_BITS: begin
                if (bit_count == 4'd7) // Received 8 data bits
                    next_state = STOP_BIT;
            end
            
            STOP_BIT: begin
                if (in == 1) begin // Valid stop bit
                    done = 1;
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            
            ERROR: begin
                if (in == 1) // Wait for idle (stop bit).
                    next_state = IDLE;
            end
            
            default: next_state = IDLE;
        endcase
    end
endmodule
