module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    reg [3:0] state, next_state;  // State registers
    reg [7:0] data;  // Data register for storing received byte
    reg [2:0] bit_count;  // Counter for received bits

    // State encoding
    localparam IDLE = 4'd0,
               START = 4'd1,
               DATA = 4'd2,
               STOP = 4'd3,
               DONE = 4'd4;

    // State transition
    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @ (*) begin
        next_state = state;  // Default state
        done = 0;
        case (state)
            IDLE: begin
                if (in == 0)  // Detect start bit (0)
                    next_state = START;
            end
            START: begin
                next_state = DATA;
                bit_count = 0;
            end
            DATA: begin
                if (bit_count == 7)
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1) begin  // Check stop bit (1)
                    next_state = DONE;
                end else begin
                    next_state = IDLE;  // Invalid stop bit, reset to idle
                end
            end
            DONE: begin
                done = 1;
                next_state = IDLE;
            end
        endcase
    end

    // Data load logic and bit count
    always @ (posedge clk) begin
        if (state == DATA) begin
            data[bit_count] <= in;  // Load data bits
            bit_count <= bit_count + 1;
        end
        if (state == DONE) begin
            out_byte <= data;  // Output the correctly received byte
        end
    end

endmodule
