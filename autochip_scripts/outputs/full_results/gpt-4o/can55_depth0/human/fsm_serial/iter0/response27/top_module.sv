module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);
    reg [3:0] state, next_state;
    reg [7:0] data;
    reg [2:0] bit_counter;

    // State encoding
    localparam IDLE = 4'd0,
               START_BIT = 4'd1,
               DATA_BITS = 4'd2,
               STOP_BIT = 4'd3,
               DONE = 4'd4,
               ERROR = 4'd5;
    
    // Synchronous state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 0;
            done <= 0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state; // Default to hold state
        done = 0; // Default to not done
        case (state)
            IDLE: begin
                if (in == 0) // Start bit detected
                    next_state = START_BIT;
            end
            START_BIT: begin
                next_state = DATA_BITS;
                bit_counter = 0;
            end
            DATA_BITS: begin
                if (bit_counter == 7) // All 8 bits received
                    next_state = STOP_BIT;
                else
                    next_state = DATA_BITS;
            end
            STOP_BIT: begin
                if (in == 1) begin // Stop bit detected
                    next_state = DONE;
                end else begin // Stop bit error
                    next_state = ERROR;
                end
            end
            DONE: begin
                done = 1; // Signal that byte reception is complete
                if (in == 1) // Line idle
                    next_state = IDLE;
                else // Another start bit detected
                    next_state = START_BIT;
            end
            ERROR: begin
                if (in == 1) // Wait until the line is idle
                    next_state = IDLE;
            end
        endcase
    end

    // Data input logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_counter <= 0;
            data <= 0;
        end else begin
            case (state)
                DATA_BITS: begin
                    data[bit_counter] <= in;
                    bit_counter <= bit_counter + 1;
                end
                ERROR: begin
                    bit_counter <= 0;
                    data <= 0;
                end
                default: begin
                    bit_counter <= 0;
                end
            endcase
        end
    end

endmodule
