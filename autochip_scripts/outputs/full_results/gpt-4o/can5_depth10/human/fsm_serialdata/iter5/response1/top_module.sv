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

    // State transition logic
    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 3'b000;
            shift_register <= 8'b0;
            out_byte <= 8'b0;
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
            end else begin
                done <= 1'b0;
            end

            if (next_state == IDLE) begin
                bit_counter <= 0;
            end
        end
    end

    // Next state logic
    always @ (*) begin
        next_state = state;
        case (state)
            IDLE: begin
                done = 0;
                if (in == 1'b0)
                    next_state = START;
            end

            START: begin
                if (bit_counter == 3'd0) begin
                    next_state = DATA;
                    bit_counter = 3'd1;  // Move to the first bit position to store the bit data
                end
            end

            DATA: begin
                if (bit_counter == 3'd8) begin
                    next_state = STOP;
                end
            end

            STOP: begin
                if (in == 1'b1)
                    next_state = IDLE;
            end

            default: next_state = IDLE;
        endcase
    end
endmodule
