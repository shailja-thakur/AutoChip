module top_module (
	input clk,
	input in,
	input reset,
	output reg done
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE    = 3'b000,   // Idle state, waiting for start bit
        START   = 3'b001,   // Start bit detected, waiting for data bits
        DATA    = 3'b010,   // Receiving data bits
        STOP    = 3'b011,   // Waiting for stop bit
        ERROR   = 3'b100    // Error detected, search for stop bit before resetting
    } state_t;
    
    reg [2:0] state, next_state;
    reg [2:0] bit_count; // Counter to count bits
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'b000;
            done <= 1'b0;
        end else begin
            state <= next_state;
            // Reset done signal after the cycle it is asserted
            if (done)
                done <= 1'b0;
        end
    end

    always @(*) begin
        // Default values
        next_state = state;
        case (state)
            IDLE: begin
                if (in == 1'b0) // Start bit detected
                    next_state = START;
            end
            START: begin
                if (in == 1'b0) // Confirming it's still a start bit
                    next_state = DATA;
            end
            DATA: begin
                if (bit_count == 3'b111) // 8 data bits received
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) begin // Valid stop bit
                    next_state = IDLE;
                end else begin // Invalid stop bit
                    next_state = ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1) // Waiting for idle or valid stop bit
                    next_state = IDLE;
            end
        endcase
    end

    always @(posedge clk) begin
        if (state == DATA) begin
            bit_count <= bit_count + 1;
        end else begin
            bit_count <= 3'b000; // Reset bit count in other states
        end

        // Assert done when a full valid byte has been received
        if (state == STOP && in == 1'b1) begin
            done <= 1'b1;
        end
    end
    
endmodule
