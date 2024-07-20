module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    reg [3:0] state, next_state;
    reg [3:0] bit_counter;     // 4 bits to count from 0 to 8 (for 8 bits + 1 stop bit)
    reg [7:0] shift_register;

    // State encoding
    localparam IDLE   = 4'b0000;
    localparam START  = 4'b0001;
    localparam DATA   = 4'b0010;
    localparam STOP   = 4'b0011;

    // State transition and output logic
    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 0;
            shift_register <= 0;
            out_byte <= 0;
            done <= 0;
        end else begin
            state <= next_state;

            case (state)
                START: begin
                    if (bit_counter == 4'd0) begin
                        shift_register <= 0;
                    end
                end
                DATA: begin
                    shift_register[bit_counter] <= in;
                    bit_counter <= bit_counter + 1;
                end
                STOP: begin
                    if (in == 1'b1) begin
                        out_byte <= shift_register;
                        done <= 1'b1;
                        bit_counter <= 0;
                    end else begin
                        done <= 1'b0;
                    end
                end
                default: begin
                    done <= 1'b0;
                end
            endcase

            if (state != STOP) begin
                done <= 1'b0;
            end
        end
    end

    // Next state logic
    always @ (*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (in == 1'b0) begin     // Detecting start bit
                    next_state = START;
                end
            end

            START: begin
                next_state = DATA;        // Move to DATA state
            end

            DATA: begin
                if (bit_counter == 4'd7) begin
                    next_state = STOP;
                end else begin
                    next_state = DATA;
                end
            end

            STOP: begin
                if (in == 1'b1) begin    // Valid stop bit
                    next_state = IDLE;
                end else begin
                    next_state = STOP;   // Stay in STOP state until a valid stop bit (1) is detected
                end
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule
