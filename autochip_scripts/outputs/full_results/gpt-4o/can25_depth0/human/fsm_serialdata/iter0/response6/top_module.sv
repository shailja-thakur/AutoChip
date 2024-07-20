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
        START_BIT,
        DATA_BITS,
        STOP_BIT,
        ERROR
    } state_t;

    state_t state, next_state;
    reg [3:0] bit_counter;
    reg [7:0] data;

    // State transition 
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 0;
            out_byte <= 8'd0;
            done <= 0;
            data <= 8'd0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                done = 0;
                if (!in) // Start bit detected (in is 0)
                    next_state = START_BIT;
            end
            
            START_BIT: begin
                if (bit_counter == 0) begin
                    bit_counter = bit_counter + 1;
                    next_state = DATA_BITS;
                end
            end
            
            DATA_BITS: begin
                if (bit_counter < 8) begin
                    bit_counter = bit_counter + 1;
                    data[bit_counter-1] = in; // Reading LSB first
                    next_state = DATA_BITS;
                end
                else begin
                    bit_counter = 0;
                    next_state = STOP_BIT;
                end
            end
            
            STOP_BIT: begin
                if (in) begin // Stop bit must be 1
                    out_byte = data;
                    done = 1;
                    next_state = IDLE;
                end else begin
                    next_state = ERROR; // Error if stop bit is not 1
                end
            end
            
            ERROR: begin
                if (in) // Wait until line becomes idle (in = 1)
                    next_state = IDLE;
            end
            
            default: next_state = IDLE;
        endcase
    end
endmodule
