module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE        = 3'b000,
        START_BIT   = 3'b001,
        DATA_BITS   = 3'b010,
        STOP_BIT    = 3'b011,
        DONE        = 3'b100,
        ERROR       = 3'b101
    } state_t;

    // State, next state variables
    state_t state, next_state;
    reg [2:0] data_bit_count;

    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            data_bit_count <= 3'b0;
        end else begin
            state <= next_state;
            if (next_state == DATA_BITS)
                data_bit_count <= data_bit_count + 1;
            else if (next_state != DATA_BITS)
                data_bit_count <= 3'b0;
        end
    end

    // Combinational logic for next state and output
    always @(*) begin
        done = 1'b0; // Default value
        next_state = state; // Default to stay in the same state
        
        case (state)
            IDLE: begin
                if (in == 1'b0) begin // Detect start bit
                    next_state = START_BIT;
                end
            end
            
            START_BIT: begin
                if (in == 1'b0) begin // Valid start bit
                    next_state = DATA_BITS;
                end else begin // Invalid start bit, go back to IDLE
                    next_state = IDLE;
                end
            end
            
            DATA_BITS: begin
                if (data_bit_count < 3'b111) begin
                    next_state = DATA_BITS; // Continue collecting data bits
                end else begin
                    next_state = STOP_BIT; // Move to stop bit check after 8 data bits
                end
            end
            
            STOP_BIT: begin
                if (in == 1'b1) begin // Valid stop bit
                    next_state = DONE;
                end else begin // Invalid stop bit
                    next_state = ERROR;
                end
            end
            
            DONE: begin
                done = 1'b1; // Indicate completion
                if (in == 1'b1) begin
                    next_state = IDLE; // Wait for next start bit
                end
            end
            
            ERROR: begin
                if (in == 1'b1) begin // Wait until line goes back to idle
                    next_state = IDLE;
                end
            end

            default: next_state = IDLE;
        endcase
    end
endmodule
