module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State Encoding
    typedef enum reg [3:0] {
        IDLE            = 4'b0000,
        START_BIT       = 4'b0001,
        DATA_BITS       = 4'b0010,
        STOP_BIT        = 4'b0011,
        ERROR           = 4'b0100
    } state_t;

    state_t current_state, next_state;
    reg [2:0] bit_count;
    reg [7:0] shift_reg;
    
    // State Transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 0;
            shift_reg <= 0;
            out_byte <= 8'b0;
            done <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == DATA_BITS) begin
                bit_count <= bit_count + 1;
                shift_reg <= {in, shift_reg[7:1]};
            end
            if (current_state == STOP_BIT) begin
                bit_count <= 0;
                out_byte <= shift_reg;
                done <= 1;
            end else begin
                done <= 0;
            end
        end
    end

    // Next State logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (in == 1'b0)              // Detect start bit
                    next_state = START_BIT;
                else
                    next_state = IDLE;
            end
            START_BIT: begin
                next_state = (in == 1'b0) ? DATA_BITS : IDLE; // Valid start bit, move to data bits
            end
            DATA_BITS: begin
                if (bit_count == 3'd7)       // 8 data bits received
                    next_state = STOP_BIT;
                else
                    next_state = DATA_BITS;  // Continue receiving data bits
            end
            STOP_BIT: begin
                next_state = (in == 1'b1) ? IDLE : ERROR; // Valid stop bit, move to idle
            end
            ERROR: begin
                next_state = (in == 1'b1) ? IDLE : ERROR; // Wait for line to be idle
            end
            default: next_state = IDLE;
        endcase
    end

endmodule
