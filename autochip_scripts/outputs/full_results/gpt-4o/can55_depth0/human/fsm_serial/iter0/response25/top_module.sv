module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // Define the states of the FSM
    typedef enum logic [2:0] {
        IDLE = 3'b000,   // Idle state, line is idle (logic 1)
        START = 3'b001,  // Start bit detected (logic 0)
        DATA = 3'b010,   // Receiving data bits
        STOP = 3'b011    // Stop bit verification
    } state_t; 

    state_t state, next_state;

    reg [2:0] bit_count;  // Counter for received data bits
    reg [7:0] data;       // To store the received data byte

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'b0;
            done <= 0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and bit counting
    always @(*) begin
        case (state)
            IDLE: begin
                if (!in)  // If start bit (0) is detected
                    next_state = START;
                else
                    next_state = IDLE;
            end

            START: begin
                next_state = DATA;
            end

            DATA: begin
                if (bit_count == 3'd7)  // If all 8 data bits are received
                    next_state = STOP;
                else
                    next_state = DATA;
            end

            STOP: begin
                if (in)  // If stop bit (logic 1) is detected
                    next_state = IDLE;
                else
                    next_state = STOP;  // Wait for the stop bit
            end

            default: next_state = IDLE;
        endcase
    end

    // Data bit counting and done signal generation
    always @(posedge clk) begin
        if (state == DATA) begin
            data[bit_count] <= in;  // Capture the incoming data bits
            bit_count <= bit_count + 1;
        end else if (state == IDLE || state == STOP) begin
            bit_count <= 0;
        end

        if (state == STOP && in) begin
            done <= 1;  // Set done when a complete byte is received with a valid stop bit
        end else begin
            done <= 0;
        end
    end

endmodule
