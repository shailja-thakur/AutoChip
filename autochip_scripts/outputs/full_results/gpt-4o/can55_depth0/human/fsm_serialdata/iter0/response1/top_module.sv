module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State encoding
    parameter IDLE = 3'b000,
              START = 3'b001,
              DATA = 3'b010,
              CHECK_STOP = 3'b011,
              DONE = 3'b100;

    reg [2:0] state, next_state;
    reg [2:0] bit_counter;
    reg [7:0] data_register;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in == 1'b0)  // Detect start bit
                    next_state = START;
                else
                    next_state = IDLE;
            end
            START: begin
                next_state = DATA;
            end
            DATA: begin
                if (bit_counter == 3'd7)
                    next_state = CHECK_STOP;
                else
                    next_state = DATA;
            end
            CHECK_STOP: begin
                if (in == 1'b1)
                    next_state = DONE;
                else
                    next_state = IDLE;  // Error, wait for next start bit
            end
            DONE: begin
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output and state operations
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_counter <= 3'd0;
            data_register <= 8'd0;
            out_byte <= 8'd0;
            done <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 1'b0;
                    bit_counter <= 3'd0;
                end
                START: begin
                    done <= 1'b0;
                end
                DATA: begin
                    data_register[bit_counter] <= in;
                    bit_counter <= bit_counter + 1;
                end
                CHECK_STOP: begin
                    done <= 1'b0;
                end
                DONE: begin
                    out_byte <= data_register;
                    done <= 1'b1;
                end
            endcase
        end
    end

endmodule
