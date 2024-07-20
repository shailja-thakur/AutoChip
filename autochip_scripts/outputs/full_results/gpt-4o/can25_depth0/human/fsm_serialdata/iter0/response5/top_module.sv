module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    reg [3:0] state, next_state;
    reg [7:0] data;
    reg [3:0] bit_count;

    // State encoding
    localparam IDLE       = 4'd0,
               START_BIT  = 4'd1,
               DATA_BITS  = 4'd2,
               STOP_BIT   = 4'd3,
               DONE       = 4'd4,
               ERROR      = 4'd5;

    // State transitions
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 4'd0;
            data <= 8'd0;
            done <= 1'b0;
            out_byte <= 8'd0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        done = 1'b0;
        case (state)
            IDLE: begin
                if (~in) next_state = START_BIT;  // Detect start bit (0)
            end
            START_BIT: begin
                if (bit_count == 4'd1) begin
                    next_state = DATA_BITS; // Move to data bits collection
                    bit_count = 4'd0; // Reset bit counter for data bits
                end else begin
                    bit_count = bit_count + 4'd1;
                end
            end
            DATA_BITS: begin
                if (bit_count == 4'd8) begin
                    next_state = STOP_BIT;  // All data bits received
                    bit_count = 4'd0; // Reset bit counter for stop bit
                end else begin
                    bit_count = bit_count + 4'd1;
                    data[bit_count] = in;  // Collect data bit
                end
            end
            STOP_BIT: begin
                if (in) begin  // Stop bit should be 1
                    next_state = DONE;
                    out_byte = data;
                    done = 1'b1;
                end else begin
                    next_state = ERROR;  // Error as stop bit is not 1, wait for a valid stop bit
                end
            end
            DONE: begin
                next_state = IDLE;  // Done signal is asserted, go back to idle
            end
            ERROR: begin
                if (in) next_state = IDLE;  // Correct stop bit found
            end
            default: next_state = IDLE;
        endcase
    end
endmodule
