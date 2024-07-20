module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State Declaration
    typedef enum logic [2:0] {
        IDLE,
        START,
        DATA,
        STOP
    } state_t;
    
    state_t state, next_state;

    // Data and bit counters
    reg [7:0] data;
    reg [2:0] bit_counter;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            data <= 8'b0;
            bit_counter <= 3'b0;
            done <= 1'b0;
        end
        else begin
            state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            out_byte <= 8'b0;
            done <= 1'b0;
            bit_counter <= 3'b0;
        end
        else begin
            case (state)
                IDLE: begin
                    done <= 1'b0;
                    if (in == 1'b0) begin  // Detect start bit
                        next_state <= START;
                    end
                    else begin
                        next_state <= IDLE;
                    end
                end

                START: begin
                    bit_counter <= 3'b0;
                    if (in == 1'b0) begin  // Confirm start bit still valid
                        next_state <= DATA;
                    end
                    else begin
                        next_state <= IDLE;
                    end
                end

                DATA: begin
                    data[bit_counter] <= in;
                    if (bit_counter == 3'b111) begin
                        next_state <= STOP;
                    end
                    else begin
                        next_state <= DATA;
                    end
                    bit_counter <= bit_counter + 1;
                end

                STOP: begin
                    if (in == 1'b1) begin  // Check stop bit
                        out_byte <= data;
                        done <= 1'b1;
                        next_state <= IDLE;
                    end
                    else begin
                        next_state <= START;  // Incorrect stop bit: start over when another start bit is detected
                    end
                end

                default: begin
                    next_state <= IDLE;
                end

            endcase
        end
    end

endmodule
