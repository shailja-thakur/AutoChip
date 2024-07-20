module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    
    // State declarations
    typedef enum reg [2:0] {
        IDLE,
        START,
        DATA,
        STOP
    } state_t;
    
    state_t state, next_state;
    reg [2:0] bit_counter;  // To count the 8 data bits
    reg [7:0] byte_buffer;  // To store received data bits
    
    // State transition 
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic and output logic
    always @(*) begin
        next_state = state;
        done = 0;
        case (state)
            IDLE: begin
                if (in == 0)  // Detect start bit
                    next_state = START;
            end
            
            START: begin
                next_state = DATA;
                bit_counter = 0;
            end
            
            DATA: begin
                if (bit_counter < 7) begin
                    next_state = DATA;
                end else begin
                    next_state = STOP;
                end
            end
            
            STOP: begin
                if (in == 1) begin  // Expect stop bit
                    next_state = IDLE;
                    done = 1;
                end else begin
                    next_state = STOP;  // Error: Wait for stop bit
                end
            end
        endcase
    end
    
    // Data bit collection and bit_counter update
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_counter <= 0;
            byte_buffer <= 8'b0;
            out_byte <= 8'b0;
        end else if (state == DATA) begin
            byte_buffer[bit_counter] <= in;
            bit_counter <= bit_counter + 1;
        end else if (state == STOP && in == 1) begin
            out_byte <= byte_buffer;  // Place the complete byte in the output register
        end
    end
    
endmodule
