module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    // State declarations
    typedef enum logic [2:0] {
        IDLE        = 3'b000,
        START_BIT   = 3'b001,
        DATA_BITS   = 3'b010,
        STOP_BIT    = 3'b011,
        ERROR       = 3'b100
    } state_t;
    
    state_t state, next_state;
    reg [2:0] bit_count;
    reg [7:0] data;
    
    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 0;
            data <= 8'b0;
        end else begin
            state <= next_state;
            if (state == DATA_BITS) begin
                data <= {in, data[7:1]};
                bit_count <= bit_count + 1;
            end else if (state == IDLE || state == STOP_BIT || state == ERROR) begin
                bit_count <= 0;
            end
        end
    end
    
    // Next state logic
    always_comb begin
        done = 0;
        next_state = state;
        case(state)
            IDLE: begin
                if (in == 0) // Detect start bit
                    next_state = START_BIT;
                else
                    next_state = IDLE;
            end
            START_BIT: begin
                next_state = DATA_BITS;
            end
            DATA_BITS: begin
                if (bit_count == 3'd7) // All 8 data bits received
                    next_state = STOP_BIT;
                else
                    next_state = DATA_BITS;
            end
            STOP_BIT: begin
                if (in == 1) begin // Correct stop bit
                    out_byte = data;
                    done = 1;
                    next_state = IDLE;
                end else begin // Incorrect stop bit
                    next_state = ERROR;
                end
            end
            ERROR: begin
                if (in == 1) // Wait for idle state
                    next_state = IDLE;
                else
                    next_state = ERROR;
            end
            default: next_state = IDLE;
        endcase
    end
endmodule
