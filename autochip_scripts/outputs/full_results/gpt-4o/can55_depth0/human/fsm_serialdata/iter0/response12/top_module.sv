module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State definitions
    typedef enum reg [2:0] {
        IDLE,       // Idle state waiting for start bit
        START_BIT,  // State for the start bit
        DATA_BITS,  // State for the 8 data bits
        STOP_BIT    // State for the stop bit
    } state_t;
    
    // State register
    reg [2:0] state, next_state;
    reg [2:0] bit_count;  // Counter for the data bits
    reg [7:0] shift_reg;  // Shift register to hold the data byte

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= IDLE;
        else 
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in == 0)        // Detect start bit (0)
                    next_state = START_BIT;
                else
                    next_state = IDLE;
            end
            START_BIT: begin
                next_state = DATA_BITS;
            end
            DATA_BITS: begin
                if (bit_count == 3'd7) // Wait for 8 data bits
                    next_state = STOP_BIT;
                else
                    next_state = DATA_BITS;
            end
            STOP_BIT: begin
                if (in == 1)            // Detect stop bit (1)
                    next_state = IDLE;
                else
                    next_state = STOP_BIT; // Wait if stop bit is not correct
            end
            default: next_state = IDLE;
        endcase
    end

    // Output and register update logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_count <= 0;
            shift_reg <= 0;
            out_byte <= 8'b0;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 0;
                end
                START_BIT: begin
                    bit_count <= 0;
                    shift_reg <= 8'b0;  // Clear shift register
                end
                DATA_BITS: begin
                    if (bit_count < 3'd7) begin
                        shift_reg <= {in, shift_reg[7:1]}; // Shift in data bits (LSB first)
                        bit_count <= bit_count + 1;
                    end else begin
                        shift_reg <= {in, shift_reg[7:1]}; // Shift in the last bit
                        out_byte <= {in, shift_reg[7:1]};
                    end
                end
                STOP_BIT: begin
                    if(in == 1) begin
                        done <= 1;
                    end else begin
                        done <= 0;  // If stop bit is incorrect, do not assert done
                    end
                end
            endcase
        end
    end
endmodule
