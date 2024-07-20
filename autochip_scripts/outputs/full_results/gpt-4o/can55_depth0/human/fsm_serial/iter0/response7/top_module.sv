module top_module (
	input clk,
	input in,
	input reset,
	output reg done
);
    
    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011,
        ERROR = 3'b100
    } state_t;
    
    reg [2:0] state, next_state;
    reg [2:0] bit_counter; // Counter for the 8 data bits
    
    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 0;
        end else begin
            state <= next_state;
            if (state == DATA)
                bit_counter <= bit_counter + 1;
            else
                bit_counter <= 0;
        end
    end
    
    // Next state logic
    always @(*) begin
        next_state = state;
        done = 0;
        
        case (state)
            IDLE: begin
                if (in == 0) // Detecting start bit
                    next_state = START;
            end
            
            START: begin
                next_state = DATA; // Move to DATA state after start bit
            end
            
            DATA: begin
                if (bit_counter == 3'd7) // All 8 data bits received
                    next_state = STOP;
            end
            
            STOP: begin
                if (in == 1) begin // Valid stop bit detected
                    done = 1;
                    next_state = IDLE;
                end else
                    next_state = ERROR;
            end
            
            ERROR: begin
                if (in == 1) // Waiting for idle or stop bit
                    next_state = IDLE;
            end
            
            default: next_state = IDLE;
        endcase
    end
    
endmodule
