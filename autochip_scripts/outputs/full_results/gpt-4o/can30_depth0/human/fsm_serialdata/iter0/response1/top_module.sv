module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    // State encoding
    typedef enum reg [2:0] {
        IDLE  = 3'd0,
        START = 3'd1,
        DATA  = 3'd2,
        STOP  = 3'd3
    } state_t;

    reg [2:0] state, next_state;
    reg [2:0] bit_count;
    reg [7:0] byte_shift;
    
    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            done <= 0;
        end else begin
            state <= next_state;
        end
    end
    
    // State machine transitions
    always @(*) begin
        next_state = state;  // default to no state change
        done = 0;  // default to not done
        
        case (state)
            IDLE: begin
                if (!in) begin  // look for start bit
                    next_state = START;
                end
            end
            START: begin
                next_state = DATA;
                bit_count = 0;
            end
            DATA: begin
                if (bit_count == 3'd7) begin
                    next_state = STOP;
                end
            end
            STOP: begin
                if (in) begin  // verify stop bit
                    next_state = IDLE;
                    done = 1;  // correctly received a byte
                end else begin
                    // stay in STOP until stop bit is found
                    next_state = STOP;
                end
            end
        endcase
    end
    
    // Shift register and bit count (synchronous logic)
    always @(posedge clk) begin
        if (reset) begin
            byte_shift <= 8'b0;
            bit_count <= 3'b0;
        end else if (state == DATA) begin
            byte_shift <= {in, byte_shift[7:1]};  // shift in data bits (LSB first)
            bit_count <= bit_count + 1;
        end else if (state == STOP && bit_count == 3'd7) begin
            out_byte <= byte_shift;  // latch the received byte
        end
    end

endmodule
