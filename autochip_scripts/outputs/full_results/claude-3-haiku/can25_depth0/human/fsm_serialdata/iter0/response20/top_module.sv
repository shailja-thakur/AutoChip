module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

// Define the states of the finite state machine
localparam STATE_IDLE = 0;
localparam STATE_START_BIT = 1;
localparam STATE_DATA_BITS = 2;
localparam STATE_STOP_BIT = 3;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_register;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_IDLE;
        bit_count <= 0;
        data_register <= 0;
        out_byte <= 0;
        done <= 0;
    end else begin
        case (state)
            STATE_IDLE: begin
                if (!in) begin // Start bit detected
                    state <= STATE_START_BIT;
                    bit_count <= 0;
                    data_register <= 0;
                end
            end
            STATE_START_BIT: begin
                if (in) begin // Valid start bit found
                    state <= STATE_DATA_BITS;
                end else begin
                    state <= STATE_IDLE; // Start bit not valid, go back to idle
                end
            end
            STATE_DATA_BITS: begin
                data_register[bit_count] <= in; // Shift in data bit
                bit_count <= bit_count + 1;
                if (bit_count == 8) begin // All 8 data bits received
                    state <= STATE_STOP_BIT;
                end
            end
            STATE_STOP_BIT: begin
                if (in) begin // Valid stop bit found
                    out_byte <= data_register;
                    done <= 1;
                    state <= STATE_IDLE;
                end else begin
                    state <= STATE_IDLE; // Stop bit not valid, go back to idle
                end
                done <= 0; // Clear done signal
            end
            default: state <= STATE_IDLE;
        endcase
    end
end

endmodule
