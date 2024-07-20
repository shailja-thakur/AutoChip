module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011,
        WAIT_STOP = 3'b100
    } state_t;

    state_t current_state, next_state;
    reg [2:0] bit_counter;
    reg [7:0] data_bits;

    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_counter <= 3'd0;
            data_bits <= 8'd0;
            out_byte <= 8'd0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            
            // Latch values at each clock cycle
            case (current_state)
                DATA: if (bit_counter < 7) bit_counter <= bit_counter + 1;
                default: bit_counter <= 3'd0;
            endcase

            case (current_state)
                DATA: if (bit_counter <= 7) data_bits[bit_counter] <= in;
                STOP: out_byte <= data_bits;
            endcase
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        done = 1'b0;
        
        case (current_state)
            IDLE: begin
                if (in == 1'b0) next_state = START;
            end
            START: begin
                if (in == 1'b0) next_state = DATA;
                else next_state = IDLE;  // If not a valid start bit, go back to idle
            end
            DATA: begin
                if (bit_counter == 7) next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                    done = 1'b1;
                end else next_state = WAIT_STOP;  // Invalid stop bit, wait for next idle
            end
            WAIT_STOP: begin
                if (in == 1'b1) next_state = IDLE;
            end
        endcase
    end

endmodule
