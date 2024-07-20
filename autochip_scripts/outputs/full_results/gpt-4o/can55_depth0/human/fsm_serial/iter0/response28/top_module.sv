module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State declaration
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011,
        ERROR = 3'b100
    } state_t;
    
    state_t current_state, next_state;
    reg [2:0] bit_count; // to count the 8 data bits
    
    always @(posedge clk or posedge reset) begin
        if(reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end
    
    always @(*) begin
        // Default values
        next_state = current_state;
        done = 0;
        
        case(current_state)
            IDLE: begin
                if(~in) // Start bit detected
                    next_state = START;
            end
            
            START: begin
                if(in) // Still reading start bit
                    next_state = IDLE;
                else
                    next_state = DATA;
            end
            
            DATA: begin
                if(bit_count == 3'd7) // Last data bit received
                    next_state = STOP;
            end
            
            STOP: begin
                if(in) begin // Stop bit must be 1
                    done = 1; // Byte successfully received
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            
            ERROR: begin
                if(in) // Wait for a stop bit
                    next_state = IDLE;
            end
            
            default: next_state = IDLE; // default state
        endcase
    end
    
    always @(posedge clk or posedge reset) begin
        if(reset)
            bit_count <= 3'd0;
        else if(current_state == DATA)
            bit_count <= bit_count + 1;
        else
            bit_count <= 3'd0;
    end
endmodule
