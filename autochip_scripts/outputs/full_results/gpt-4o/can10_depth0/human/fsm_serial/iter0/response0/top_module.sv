module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE   = 3'd0,
        START  = 3'd1,
        DATA   = 3'd2,
        STOP   = 3'd3,
        ERROR  = 3'd4
    } state_t;
    
    state_t current_state, next_state;
    reg [2:0] bit_counter;  // To count 8 data bits
    reg [7:0] data;         // To store received data bits
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_counter <= 3'd0;
            data <= 8'd0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end
    
    always_comb begin
        next_state = current_state;  // Default to hold state
        done = 1'b0;                 // Default done to 0
        
        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin  // Start bit detected
                    next_state = START;
                end
            end
            
            START: begin
                next_state = DATA;     // Move to data reception state
                bit_counter = 3'd0;    // Reset bit counter
            end
            
            DATA: begin
                data[bit_counter] = in;   // Store the incoming data bit
                
                if (bit_counter == 3'd7) begin  // Last data bit received
                    next_state = STOP;
                end else begin
                    bit_counter = bit_counter + 1;
                end
            end
            
            STOP: begin
                if (in == 1'b1) begin   // Stop bit detected
                    done = 1'b1;        // Indicate byte received correctly
                    next_state = IDLE;  // Go back to IDLE state for the next byte
                end else begin
                    next_state = ERROR; // Error state if stop bit is not 1
                end
            end
            
            ERROR: begin
                if (in == 1'b1) begin   // Wait until line goes back to idle
                    next_state = IDLE;
                end
            end
            
            default: next_state = IDLE;
        endcase
    end

endmodule
