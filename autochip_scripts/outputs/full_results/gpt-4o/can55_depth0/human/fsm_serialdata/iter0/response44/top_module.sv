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
    reg [2:0] bit_counter;  // Counter for the 8 data bits
    reg [7:0] data_byte;    // Register to hold the received byte

    // State transition logic
    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_counter <= 3'b000;
            out_byte <= 8'b00000000;
            done <= 1'b0;
            data_byte <= 8'b00000000;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        next_state = current_state;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin  // Start bit detected
                    next_state = START;
                end
            end

            START: begin
                if (in == 1'b0) begin  // Start bit should be held low
                    next_state = DATA;
                    bit_counter = 3'b000;
                end else begin
                    next_state = IDLE;  // Invalid start bit
                end
            end

            DATA: begin
                data_byte[bit_counter] = in;
                if (bit_counter == 3'b111) begin
                    next_state = STOP;
                end
                bit_counter += 1;
            end

            STOP: begin
                if (in == 1'b1) begin  // Valid stop bit
                    out_byte = data_byte;
                    done = 1'b1;
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;  // Invalid stop bit
                end
            end

            ERROR: begin
                if (in == 1'b1) begin  // Wait for idle
                    next_state = IDLE;
                end
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule
