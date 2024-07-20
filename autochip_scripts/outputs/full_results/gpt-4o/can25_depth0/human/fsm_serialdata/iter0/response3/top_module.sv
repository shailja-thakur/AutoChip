module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        RECEIVE = 3'b010,
        STOP = 3'b011,
        DONE = 3'b100
    } state_t;
    
    state_t current_state, next_state;
    reg [2:0] bit_index;      // Keep track of the number of received data bits
    reg [7:0] data_byte;      // Temporary storage for incoming data bits

    // Synchronous state and data transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            out_byte <= 8'b0;
            bit_index <= 3'b0;
            data_byte <= 8'b0;
            done <= 1'b0;
        end
        else begin
            current_state <= next_state;
            bit_index <= (current_state == RECEIVE) ? bit_index + 3'b1 : 3'b0;
            data_byte <= (current_state == RECEIVE) ? {in, data_byte[7:1]} : data_byte; // Shift in LSB first
            if (current_state == DONE)
                out_byte <= data_byte;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = current_state; // Default to retain current state
        done = 1'b0; // Default to done being low

        case (current_state)
            IDLE: begin
                if (in == 1'b0) // Detect start bit (0)
                    next_state = START;
            end

            START: begin
                next_state = RECEIVE; // After detecting start bit, go to RECEIVE state
            end

            RECEIVE: begin
                if (bit_index == 3'd7) // Check if 8 data bits have been received
                    next_state = STOP;
                else
                    next_state = RECEIVE;
            end

            STOP: begin
                if (in == 1'b1) begin // Check if stop bit (1) is received
                    next_state = DONE;
                    done = 1'b1; // Indicate byte is fully received
                end else
                    next_state = IDLE; // If stop bit is not correct, go back to IDLE
            end

            DONE: begin
                next_state = IDLE; // After processing is completed, return to IDLE state
            end
            
            default: next_state = IDLE; // Default case to handle unexpected states
        endcase
    end

endmodule
