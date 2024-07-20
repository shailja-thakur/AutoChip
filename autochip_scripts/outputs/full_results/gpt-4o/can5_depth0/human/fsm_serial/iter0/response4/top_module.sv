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

    reg [2:0] current_state, next_state;
    reg [3:0] bit_counter; // to count 8 data bits
    reg [7:0] data; // to accumulate data bits

    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    always @(*) begin
        next_state = current_state; // default to the same state
        case (current_state)
            IDLE: begin
                if (in == 0) // Start bit detected
                    next_state = START;
            end
            
            START: begin
                next_state = DATA;
                bit_counter = 0;
            end
            
            DATA: begin
                if (bit_counter < 8) begin
                    next_state = DATA;
                end else begin
                    next_state = STOP;
                end
            end
            
            STOP: begin
                if (in == 1) // Stop bit detected
                    next_state = IDLE;
                else
                    next_state = ERROR; // Go to error state if stop bit is not 1
            end
            
            ERROR: begin
                if (in == 1) // Wait for idle (stop bit condition)
                    next_state = IDLE;
            end
        endcase
    end

    always @(posedge clk) begin
        case (current_state)
            IDLE: begin
                done <= 0;
            end
            
            START: begin
                bit_counter <= 0;
                data <= 0;
            end
            
            DATA: begin
                data[bit_counter] <= in;
                bit_counter <= bit_counter + 1;
            end
            
            STOP: begin
                if (in == 1) // Stop bit detected
                    done <= 1;
                else
                    done <= 0;
            end
            
            ERROR: begin
                done <= 0;
            end
        endcase
    end

endmodule
