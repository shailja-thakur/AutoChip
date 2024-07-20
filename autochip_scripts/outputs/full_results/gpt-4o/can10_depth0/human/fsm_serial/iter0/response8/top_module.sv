module top_module (
    input clk,
    input in,
    input reset,
    output done
);

    // Define states
    typedef enum logic [2:0] {
        IDLE,       // Waiting for start bit
        START,      // Detected start bit
        DATA,       // Receiving data bits
        STOP,       // Checking stop bit
        ERROR       // Error state: wait for correct stop bit
    } state_t;
    
    state_t state, next_state;
    logic [2:0] bit_counter; // To count 8 data bits
    logic [7:0] data;        // Store received data

    // State transition logic (sequential)
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // State transition logic (combinational)
    always_comb begin
        next_state = state;
        done = 1'b0;
        case (state)
            IDLE: begin
                if (~in) // Start bit detected
                    next_state = START;
            end
            
            START: begin
                next_state = DATA;
                bit_counter = 3'd0;
            end
            
            DATA: begin
                if (bit_counter == 3'd7)
                    next_state = STOP;
                else
                    bit_counter = bit_counter + 1;
            end
            
            STOP: begin
                if (in) // Stop bit correct
                    next_state = IDLE;
                else
                    next_state = ERROR;
                done = 1'b1; // Byte received successfully
            end
            
            ERROR: begin
                if (in) // Wait for idle
                    next_state = IDLE;
            end
        endcase
    end

    // Data capture logic
    always_ff @(posedge clk) begin
        if (~reset) begin
            if (state == DATA)
                data[bit_counter] <= in;
        end
    end

endmodule
