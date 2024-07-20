module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    typedef enum logic [2:0] {
        IDLE = 3'd0,
        START = 3'd1,
        DATA = 3'd2,
        STOP = 3'd3
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count;
    reg [7:0] data_byte;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'd0;
            done <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        done = 1'b0; // Default value
        next_state = state; // Default state remains the same
        case (state)
            IDLE: begin
                if (in == 1'b0) // Start bit received
                    next_state = START;
            end
            START: begin
                next_state = DATA; // Move to data reception state
                bit_count = 3'd0; // Reset bit counter
            end
            DATA: begin
                bit_count = bit_count + 1;
                if (bit_count == 3'd7) // Last bit of data
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) begin // Stop bit received correctly
                    done = 1'b1;
                    next_state = IDLE;
                end else
                    next_state = IDLE; // Incorrect stop bit, return to idle state
            end
            default: next_state = IDLE;
        endcase
    end

    // Data shift register
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            data_byte <= 8'd0;
        end else if (state == DATA) begin
            data_byte <= {in, data_byte[7:1]}; // Shift in the serial data
        end
    end

endmodule
