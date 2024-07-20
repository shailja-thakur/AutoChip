module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // FSM state declarations
    typedef enum reg [3:0] {
        IDLE,        // Waiting for start bit
        START_BIT,   // Start bit detected (expecting '0')
        DATA_BITS,   // Collecting 8 data bits
        STOP_BIT,    // Checking stop bit (expecting '1')
        ERROR        // Error in stop bit, wait for line to return to idle
    } state_t;
    
    state_t current_state, next_state;
    reg [7:0] data_bits;
    reg [2:0] bit_count;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            data_bits <= 8'b0;
            bit_count <= 3'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end
    
    always @(current_state, in, bit_count) begin
        next_state = current_state;
        done = 1'b0;
        
        case (current_state)
            IDLE: begin
                if (in == 1'b0) // Detect start bit
                    next_state = START_BIT;
            end
            
            START_BIT: begin
                next_state = DATA_BITS;
                bit_count = 3'b0;
            end
            
            DATA_BITS: begin
                data_bits[bit_count] = in;
                if (bit_count == 3'b111)
                    next_state = STOP_BIT;
                else
                    bit_count = bit_count + 1'b1;
            end
            
            STOP_BIT: begin
                if (in == 1'b1) begin
                    done = 1'b1; // Byte received correctly
                    next_state = IDLE;
                end else begin
                    next_state = ERROR; // Stop bit error
                end
            end
            
            ERROR: begin
                if (in == 1'b1)
                    next_state = IDLE; // Wait for line to return to idle
            end
            
            default: next_state = IDLE;
        endcase
    end

endmodule
