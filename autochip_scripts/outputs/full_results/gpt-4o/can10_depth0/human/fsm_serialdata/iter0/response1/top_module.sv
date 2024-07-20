module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    reg [3:0] state, next_state;
    reg [2:0] bit_count;
    reg [7:0] byte_buffer;

    // State encoding
    localparam IDLE       = 4'd0,
               START_BIT  = 4'd1,
               DATA_BITS  = 4'd2,
               STOP_BIT   = 4'd3;

    // State transition logic
    always @(*) begin
        next_state = state;  // Default is to stay in the current state
        case (state)
            IDLE: begin
                done = 0;
                if (in == 0) // Found start bit
                    next_state = START_BIT;
            end
            START_BIT: begin
                if (in == 0) // Confirm it's a start bit
                    next_state = DATA_BITS;
                else // False start bit detected, return to IDLE
                    next_state = IDLE;
            end
            DATA_BITS: begin
                if (bit_count == 3'd7) // After receiving 8 data bits
                    next_state = STOP_BIT;
                else
                    next_state = DATA_BITS;
            end
            STOP_BIT: begin
                if (in == 1) // Correct stop bit received
                    next_state = IDLE;
                else
                    next_state = IDLE; // Error, but go back to idle to wait for new start bit
            end
        endcase
    end

    // State and data logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            out_byte <= 8'd0;
            done <= 0;
            bit_count <= 3'd0;
            byte_buffer <= 8'd0;
        end else begin
            state <= next_state;

            case (state)
                IDLE: begin
                    bit_count <= 3'd0;
                    done <= 0;
                end
                START_BIT: begin
                    bit_count <= 3'd0;
                end
                DATA_BITS: begin
                    byte_buffer[bit_count] <= in;  // Capture serial bit
                    bit_count <= bit_count + 1;
                end
                STOP_BIT: begin
                    if (in == 1) begin
                        out_byte <= byte_buffer; // Output the received byte
                        done <= 1; // Signal the byte reception is done
                    end else begin
                        done <= 0; // Error handling: stop bit was not correct, so do not assert done
                    end
                end
            endcase
        end
    end

endmodule
