module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // Define state encoding
    typedef enum {
        IDLE,
        START,
        DATA0, DATA1, DATA2, DATA3, DATA4, DATA5, DATA6, DATA7,
        STOP
    } state_t;
    
    state_t state, next_state;
    reg [7:0] data; // Register to store the data byte
    reg [2:0] bit_cnt; // Counter to keep track of the number of received data bits

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // State transition logic
    always @(*) begin
        next_state = state; // Default state remains the same
	expect to increment to next bit
            end
            else begin
                next_state = STOP; // Move to stop bit checking
            end
        end
        STOP: begin
            if (in == 1)
                next_state = IDLE; // Byte received correctly, go back to IDLE
            else
                next_state = STOP; // Wait for stop bit
        end
    endcase
    end

    // Done signal generation
    always @(posedge clk or posedge reset) begin
        if (reset)
            done <= 0;
        else if (state == STOP && in == 1)
            done <= 1;
        else if (state == IDLE)
            done <= 0;
    end

    // Bit counter logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            bit_cnt <= 3'b0;
        else if (state == START)
            bit_cnt <= 3'b0;
        else if (state >= DATA0 && state <= DATA7)
            bit_cnt <= bit_cnt + 1;
    end

endmodule
