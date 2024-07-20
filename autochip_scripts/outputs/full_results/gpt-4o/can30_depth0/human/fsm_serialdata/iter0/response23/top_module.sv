module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    // FSM state declarations
    typedef enum reg [2:0] {
        IDLE,
        START,
        DATA,
        STOP
    } state_t;

    state_t current_state, next_state;
    reg [2:0] bit_count;  // To count the number of data bits received
    reg [7:0] data_byte;  // To store the received data bits

    // State transition logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (in == 0) // Detect start bit
                    next_state = START;
                else
                    next_state = IDLE;
            end

            START: begin
                next_state = DATA;
            end

            DATA: begin
                if (bit_count == 3'd7)
                    next_state = STOP;
                else
                    next_state = DATA;
            end

            STOP: begin
                if (in == 1) // Check for stop bit
                    next_state = IDLE;
                else
                    next_state = IDLE; // Wait for stop bit to finish
            end

            default: next_state = IDLE;
        endcase
    end

    // Sequential logic to update state and outputs
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'd0;
            out_byte <= 8'd0;
            done <= 1'b0;
            data_byte <= 8'd0;
        end
        else begin
            current_state <= next_state;
            done <= 1'b0; // Default

            case (current_state)
                IDLE: begin
                    if (next_state == START) begin
                        bit_count <= 3'd0;
                    end
                end

                START: begin
                    if (next_state == DATA) begin
                        bit_count <= 3'd0;
                        data_byte <= 8'd0;
                    end
                end

                DATA: begin
                    data_byte[bit_count] <= in;  // Store incoming data bits
                    bit_count <= bit_count + 1;
                end

                STOP: begin
                    if (next_state == IDLE && in == 1) begin
                        out_byte <= data_byte;
                        done <= 1'b1;  // Data byte received successfully
                    end
                end
            endcase
        end
    end
endmodule
