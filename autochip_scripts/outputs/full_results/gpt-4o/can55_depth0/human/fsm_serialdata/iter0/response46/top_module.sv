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
        ERROR = 3'b100
    } state_t;

    state_t current_state, next_state;
    reg [3:0] bit_counter; // 4-bit counter for 8 data bits
    reg [7:0] shift_reg;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_counter <= 4'b0000;
            shift_reg <= 8'b0;
            out_byte <= 8'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state; // Default to hold state
        done = 1'b0; // Default to not done

        case (current_state)
            IDLE: begin
                if (~in) // Detect start bit (0)
                    next_state = START;
            end
            START: begin
                next_state = DATA;
            end
            DATA: begin
                if (bit_counter == 4'd8)
                    next_state = STOP;
            end
            STOP: begin
                if (in) begin // Stop bit must be 1
                    done = 1'b1;
                    next_state = IDLE;
                end else
                    next_state = ERROR;
            end
            ERROR: begin
                if (in) // Look for the stop bit
                    next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output and counter logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_counter <= 4'b0000;
            shift_reg <= 8'b0;
            out_byte <= 8'b0;
        end else begin
            case (current_state)
                IDLE: begin
                    bit_counter <= 4'b0000;
                    shift_reg <= 8'b0;
                end
                START: begin
                    bit_counter <= 4'b0000;
                end
                DATA: begin
                    shift_reg <= {in, shift_reg[7:1]}; // Shift in LSB first
                    bit_counter <= bit_counter + 1;
                end
                STOP: begin
                    out_byte <= shift_reg; // Latch the received byte
                end
                ERROR: begin
                    bit_counter <= 4'b0000;
                    shift_reg <= 8'b0;
                end
                default: ;
            endcase
        end
    end

endmodule
