module top_module (
	input clk,
	input in,
	input reset,
	output reg done
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE       = 3'b000,
        START_BIT  = 3'b001,
        DATA_BITS  = 3'b010,
        STOP_BIT   = 3'b011,
        DONE       = 3'b100,
        ERROR      = 3'b101
    } state_t;
    
    state_t current_state, next_state;
    reg [2:0] bit_counter;
    
    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_counter <= 3'b000;
        end else begin
            current_state <= next_state;
        end
    end
    
    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (in == 1'b0) // Detected start bit
                    next_state = START_BIT;
                else
                    next_state = IDLE;
                done = 1'b0;
            end
            
            START_BIT: begin
                next_state = DATA_BITS;
                bit_counter = 3'b000;
                done = 1'b0;
            end
            
            DATA_BITS: begin
                if (bit_counter == 3'b111) // Received all 8 data bits
                    next_state = STOP_BIT;
                else
                    next_state = DATA_BITS;
                done = 1'b0;
            end
            
            STOP_BIT: begin
                if (in == 1'b1) // Correct stop bit
                    next_state = DONE;
                else
                    next_state = ERROR;
                done = 1'b0;
            end
            
            DONE: begin
                next_state = IDLE;
                done = 1'b1; // Indicate byte received successfully
            end
            
            ERROR: begin
                if (in == 1'b1) // Wait for the line to return to idle state
                    next_state = IDLE;
                else
                    next_state = ERROR;
                done = 1'b0;
            end
            
            default: begin
                next_state = IDLE;
                done = 1'b0;
            end
        endcase
    end
    
    // Bit counter logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_counter <= 3'b000;
        end else if (current_state == DATA_BITS) begin
            bit_counter <= bit_counter + 1;
        end else begin
            bit_counter <= 3'b000;
        end
    end
    
endmodule
