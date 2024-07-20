module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    reg [3:0] state, next_state;
    reg [2:0] bit_counter;           // Need 3 bits to count from 0 to 7
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

            if (state == DATA && (bit_counter < 3'd8)) begin
                shift_register[bit_counter] <= in;
                bit_counter <= bit_counter + 1;
            end

            if (state == STOP && in == 1'b1) begin
                out_byte <= shift_register;
                done <= 1'b1;
            end
        
            if (next_state == IDLE) begin
                bit_counter <= 0;
                done <= 1'b0;
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
                done = 0;
            end

            START: begin
                if (in == 1'b0)
                    next_state = DATA;     // Move to DATA state
            end

            DATA: begin
                if (bit_counter == 3'd8)
                    next_state = STOP;
                else
                    next_state = DATA;
            end

            STOP: begin
                if (in == 1'b1)        // Valid stop bit
                    next_state = IDLE;
                else
                    next_state = IDLE; 
            end

            default: next_state = IDLE;
        endcase
    end
endmodule
