module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    // State encoding
    typedef enum reg [2:0] {
        IDLE,        // Wait for start bit
        START,       // Start bit detected
        DATA,        // Receiving data bits
        STOP         // Stop bit verification
    } state_t;
    
    state_t current_state, next_state;
    reg [7:0] shift_reg; // To hold the received byte
    reg [2:0] bit_count; // Counter for data bits
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            shift_reg <= 8'b0;
            bit_count <= 3'b0;
            out_byte <= 8'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        next_state = current_state;
        done = 1'b0;
        
        case (current_state)
            IDLE: begin
                if (in == 1'b0)  // Start bit detected (logic 0)
                    next_state = START;
            end

            START: begin
                next_state = DATA;
                bit_count = 3'b0; // Initialize data bit counter
            end

            DATA: begin
                if (bit_count == 3'b111) // If all 8 bits are received
                    next_state = STOP;
                else
                    next_state = DATA;
            end

            STOP: begin
                if (in == 1'b1) begin // Stop bit detected (logic 1)
                    out_byte = shift_reg; 
                    done = 1'b1;
                end
                next_state = IDLE;  // In both cases (correct or incorrect stop bit), go to idle
            end

            default: next_state = IDLE;
        endcase
    end

    // Shift register to collect data bits
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 8'b0;
        end else if (current_state == DATA) begin
            shift_reg <= {in, shift_reg[7:1]}; // LSB first
            bit_count <= bit_count + 1'b1;
        end
    end

endmodule
