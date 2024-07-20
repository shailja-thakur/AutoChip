module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    reg [3:0] state, next_state;
    reg [2:0] bit_counter;           // Changed to 3 bits since we are counting up to 7 bits
    reg [7:0] shift_register;

    // State encoding
    localparam IDLE   = 4'b0000;
    localparam START  = 4'b0001;
    localparam DATA   = 4'b0010;
    localparam STOP   = 4'b0011;

    // State transition logic
    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 0;
            shift_register <= 0;
            out_byte <= 0;
            done <= 0;
        end else begin
            state <= next_state;

            if (state == DATA && next_state == DATA) begin
                shift_register[bit_counter] <= in;
                bit_counter <= bit_counter + 1;
            end

            if (state == STOP && next_state == IDLE) begin
                out_byte <= shift_register;
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end

            if (next_state == IDLE || next_state == START) begin
                bit_counter <= 0;
            end
        end
    end

    // Next state logic
    always @ (*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (in == 1'b0)        // Detecting start bit
                    next_state = START;
            end

            START: begin
                next_state = DATA;
            end

            DATA: begin
                if (bit_counter == 3'd7)
                    next_state = STOP;
                else
                    next_state = DATA;
            end

            STOP: begin
                if (in == 1'b1)        // Valid stop bit
                    next_state = IDLE;
                else
                    next_state = STOP; // Wait for stop bit to be correct
            end

            default: next_state = IDLE;
        endcase
    end

endmodule
