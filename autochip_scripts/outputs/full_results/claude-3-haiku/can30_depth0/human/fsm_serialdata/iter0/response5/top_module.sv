module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

// Define the states of the FSM
localparam IDLE = 2'b00, START_BIT = 2'b01, DATA_BITS = 2'b10, STOP_BIT = 2'b11;

// Internal registers
reg [1:0] state;
reg [3:0] bit_count;
reg [7:0] data_buffer;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_buffer <= 0;
        out_byte <= 0;
        done <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    state <= START_BIT;
                    bit_count <= 0;
                end
            end
            START_BIT: begin
                if (in == 1'b0) begin // Wait for start bit to complete
                    state <= DATA_BITS;
                end
            end
            DATA_BITS: begin
                data_buffer[bit_count] <= in; // Shift in data bits
                bit_count <= bit_count + 1;
                if (bit_count == 4'd7) begin // All 8 data bits received
                    state <= STOP_BIT;
                end
            end
            STOP_BIT: begin
                if (in == 1'b1) begin // Stop bit detected
                    out_byte <= data_buffer;
                    done <= 1'b1;
                    state <= IDLE;
                end
                else begin // Wait for stop bit
                    state <= STOP_BIT;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
