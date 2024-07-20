module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    reg [3:0] state, next_state;
    reg [2:0] bit_counter;
    reg [7:0] shift_register;

    // State encoding
    localparam IDLE   = 4'b0000;
    localparam START  = 4'b0001;
    localparam DATA   = 4'b0010;
    localparam STOP   = 4'b0011;
    localparam ERROR  = 4'b0100;

    // State transition logic
    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 3'b000;
            shift_register <= 8'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;

            if (state == DATA && next_state == DATA) begin
                shift_register[bit_counter] <= in;
                bit_counter <= bit_counter + 1;
            end

            if (state == STOP && next_state == IDLE) begin
                out_byte <= shift_register;
                done <= 1'b1;
                bit_counter <= 3'b000;
                shift_register <= 8'b0;
            end

            if (next_state != DATA) begin
                done <= 1'b0;
            end
        end
    end

    // Next state logic
    always @ (*) begin
        next_state = state;

        case (state)
            IDLE: begin
                if (in == 1'b0)
                    next_state = START;
            end

            START: begin
                if (in == 1'b0)
                    next_state = DATA;
                else
                    next_state = IDLE; // Stay in IDLE if start bit is not correct
            end

            DATA: begin
                if (bit_counter == 3'd7)
                    next_state = STOP;
            end

            STOP: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end else begin
                    next_state = ERROR; // Invalid stop bit
                end
            end

            ERROR: begin
                if (in == 1'b1) begin
                    next_state = IDLE; // Wait until we find a valid stop bit to return to IDLE
                end
            end

            default: next_state = IDLE;
        endcase
    end

endmodule
