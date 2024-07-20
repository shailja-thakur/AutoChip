module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State declaration
    typedef enum logic [2:0] {
        IDLE   = 3'b000,
        START  = 3'b001,
        DATA   = 3'b010,
        STOP   = 3'b011,
        ERROR  = 3'b100
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_counter;
    reg [7:0] shift_register;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 3'b000;
            shift_register <= 8'b0;
            out_byte <= 8'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;

            if (state == DATA) begin
                shift_register[bit_counter] <= in;
                bit_counter <= bit_counter + 1;
            end

            if (state == STOP && in == 1'b1) begin
                out_byte <= shift_register;
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;

        case (state)
            IDLE: begin
                bit_counter = 0;
                done = 0;
                if (in == 1'b0)
                    next_state = START;
            end

            START: begin
                if (in == 1'b0)
                    next_state = DATA;
                else
                    next_state = IDLE; // Go back to idle if start bit is not correct
            end

            DATA: begin
                if (bit_counter == 3'd7)
                    next_state = STOP;
            end

            STOP: begin
                if (in == 1'b1)
                    next_state = IDLE;
                else
                    next_state = ERROR; // Invalid stop bit
            end

            ERROR: begin
                if (in == 1'b1)
                    next_state = IDLE; // Wait until we find a valid stop bit to return to idle
            end

            default: next_state = IDLE;
        endcase
    end

endmodule
