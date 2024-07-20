module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    // State encoding
    typedef enum logic [3:0] {
        IDLE     = 4'b0001,
        START    = 4'b0010,
        DATA     = 4'b0100,
        STOP     = 4'b1000
    } state_t;
    
    state_t state, next_state;
    reg [2:0] bit_count;   // Counter for 8 data bits
    reg [7:0] data_shift;  // Shift register for received bits

    // Synchronous state transitions
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            out_byte <= 8'b0;
            done <= 1'b0;
            bit_count <= 3'd0;
            data_shift <= 8'b0;
        end
        else begin
            state <= next_state;
            if (state == DATA) begin
                data_shift <= {in, data_shift[7:1]};  // Shift in new bit
                bit_count <= bit_count + 1;
            end
            else if (state == IDLE) begin
                done <= 1'b0;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                if (in == 1'b0) 
                    next_state = START;  // Detected start bit
                else
                    next_state = IDLE;
            end
            START: begin
                next_state = DATA;
                bit_count = 3'd0;
            end
            DATA: begin
                if (bit_count == 3'd7)
                    next_state = STOP;
                else
                    next_state = DATA;
            end
            STOP: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                    out_byte = data_shift;
                    done = 1'b1;  // Byte correctly received
                end
                else begin
                    next_state = IDLE;  // Error, wait for next valid byte
                end
            end
            default: next_state = IDLE;
        endcase
    end

endmodule
