module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    typedef enum logic [2:0] {
        IDLE        = 3'b000,
        START_BIT   = 3'b001,
        DATA_BITS   = 3'b010,
        STOP_BIT    = 3'b011,
        DONE        = 3'b100
    } state_t;

    state_t current_state, next_state;
    reg [3:0] bit_count;  // To count the number of data bits received
    reg [7:0] data_byte;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (in == 1'b0)  // Detect start bit
                    next_state = START_BIT;
                else
                    next_state = IDLE;
            end

            START_BIT: begin
                next_state = DATA_BITS;
            end

            DATA_BITS: begin
                if (bit_count == 4'd8)
                    next_state = STOP_BIT;
                else
                    next_state = DATA_BITS;
            end

            STOP_BIT: begin
                if (in == 1'b1)  // Detect stop bit
                    next_state = DONE;
                else
                    next_state = IDLE;  // Wait for next proper start bit
            end

            DONE: begin
                next_state = IDLE;
            end

            default: next_state = IDLE;
        endcase
    end

    // Output and counter logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_count <= 4'd0;
            data_byte <= 8'd0;
            out_byte <= 8'd0;
            done <= 1'b0;
        end else begin
            case (current_state)
                IDLE: begin
                    done <= 1'b0;
                    bit_count <= 4'd0;
                end

                START_BIT: begin
                    done <= 1'b0;
                end

                DATA_BITS: begin
                    data_byte[bit_count] <= in;  // Capture each bit
                    bit_count <= bit_count + 1;
                end

                STOP_BIT: begin
                    if (in == 1'b1) begin
                        out_byte <= data_byte;
                        done <= 1'b1;
                    end else begin
                        done <= 1'b0;
                    end
                end

                DONE: begin
                    done <= 1'b0;  // Clear done signal for next byte reception
                end
            endcase
        end
    end

endmodule
