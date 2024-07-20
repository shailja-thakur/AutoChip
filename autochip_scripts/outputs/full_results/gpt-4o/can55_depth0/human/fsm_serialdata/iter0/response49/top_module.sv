module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    reg [3:0] state, next_state;
    reg [7:0] data;
    reg [3:0] bit_counter;

    // State encoding
    localparam IDLE       = 4'b0000,
               START_BIT  = 4'b0001,
               DATA_BITS  = 4'b0010,
               STOP_BIT   = 4'b0011,
               DONE       = 4'b0100,
               ERROR      = 4'b0101;

    // State transition logic
    always @(*) begin
        case (state)
            IDLE: next_state = (in == 1'b0) ? START_BIT : IDLE;
            START_BIT: next_state = (in == 1'b0) ? DATA_BITS : IDLE;
            DATA_BITS: next_state = (bit_counter == 4'd7) ? STOP_BIT : DATA_BITS;
            STOP_BIT: next_state = (in == 1'b1) ? DONE : ERROR;
            DONE: next_state = (in == 1'b1) ? IDLE : DONE;
            ERROR: next_state = (in == 1'b1) ? IDLE : ERROR;
            default: next_state = IDLE;
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 4'd0;
            data <= 8'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            case (state)
                IDLE: begin
                    bit_counter <= 4'd0;
                    done <= 1'b0;
                end
                START_BIT: begin
                    // Nothing to do here
                end
                DATA_BITS: begin
                    data[bit_counter] <= in;
                    bit_counter <= bit_counter + 1;
                end
                STOP_BIT: begin
                    // Nothing to do here
                end
                DONE: begin
                    out_byte <= data;
                    done <= 1'b1;
                end
                ERROR: begin
                    done <= 1'b0;
                end
                default: begin
                    // Should never reach here
                end
            endcase
        end
    end

endmodule
