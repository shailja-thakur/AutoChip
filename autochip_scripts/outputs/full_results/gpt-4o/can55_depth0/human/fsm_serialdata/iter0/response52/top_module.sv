module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State declaration
    typedef enum reg [2:0] {
        IDLE,
        START,
        DATA,
        STOP
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count;
    reg [7:0] byte_data;

    // Synchronous state and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'd0;
            byte_data <= 8'd0;
            out_byte <= 8'd0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            bit_count <= (state == DATA) ? (bit_count + 3'd1) : 3'd0;

            if (state == DATA)
                byte_data[bit_count] <= in;

            if (state == STOP && in == 1'b1)
                out_byte <= byte_data;

            done <= (state == STOP && in == 1'b1);
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        case (state)
            IDLE: 
                if (in == 1'b0)  // Detect start bit (0)
                    next_state = START;
            START:
                next_state = DATA;
            DATA:
                if (bit_count == 3'd7)
                    next_state = STOP;
            STOP:
                if (in == 1'b1)
                    next_state = IDLE;
                else
                    next_state = STOP;  // Wait for stop bit
            default:
                next_state = IDLE;
        endcase
    end

endmodule
