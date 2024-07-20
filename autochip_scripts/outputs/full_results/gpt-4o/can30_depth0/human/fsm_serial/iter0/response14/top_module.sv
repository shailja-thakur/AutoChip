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
        STOP = 3'b011
    } state_t;

    state_t current_state, next_state;
    reg [2:0] bit_count;

    // State transition
    always @ (posedge clk or posedge reset) begin
        if (reset) 
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Next state logic
    always @ (*) begin
        next_state = current_state;
        done = 1'b0;
        case (current_state)
            IDLE: begin
                if (in == 1'b0) // Detect start bit (0)
                    next_state = START;
            end
            START: begin
                if (in == 1'b0) // Still start bit
                    next_state = DATA;
            end
            DATA: begin
                if (bit_count == 3'b111) // Count 8 data bits
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) begin // Check for stop bit (1)
                    done = 1'b1;
                    next_state = IDLE;
                end else begin
                    next_state = IDLE; // If not stop bit, wait for next byte
                end
            end
        endcase
    end

    // Bit count logic
    always @ (posedge clk or posedge reset) begin
        if (reset)
            bit_count <= 3'd0;
        else if (current_state == DATA)
            bit_count <= bit_count + 1'b1;
        else
            bit_count <= 3'd0;
    end

endmodule
