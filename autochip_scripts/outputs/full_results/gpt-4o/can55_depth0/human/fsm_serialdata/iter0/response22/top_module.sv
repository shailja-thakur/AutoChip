module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

    // State Declaration
    typedef enum reg [2:0] {
        IDLE,
        START,
        DATA,
        STOP,
        DONE
    } state_t;

    state_t current_state, next_state;
    reg [2:0] bit_counter;
    reg [7:0] data_buffer;

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (in == 1'b0)  // detect start bit (0)
                    next_state = START;
                else
                    next_state = IDLE;
            end
            START: begin
                next_state = DATA;
            end
            DATA: begin
                if (bit_counter == 3'b111) // last bit of data
                    next_state = STOP;
                else
                    next_state = DATA;
            end
            STOP: begin
                if (in == 1'b1) // verify stop bit (1)
                    next_state = DONE;
                else
                    next_state = IDLE;
            end
            DONE: begin
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output and data buffer logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_counter <= 3'b000;
            data_buffer <= 8'b0;
            out_byte <= 8'b0;
            done <= 1'b0;
        end
        else begin
            case (current_state)
                IDLE: begin
                    done <= 1'b0;
                end
                START: begin
                    bit_counter <= 3'b000;
                end
                DATA: begin
                    data_buffer[bit_counter] <= in;
                    bit_counter <= bit_counter + 1;
                end
                STOP: begin
                    // nothing to accumulate
                end
                DONE: begin
                    out_byte <= data_buffer;
                    done <= 1'b1;
                end
                default: begin
                    done <= 1'b0;
                end
            endcase
        end
    end

endmodule
