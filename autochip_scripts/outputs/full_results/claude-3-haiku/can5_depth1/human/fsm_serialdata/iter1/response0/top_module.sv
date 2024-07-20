module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

// Define the states of the FSM
parameter IDLE = 0, START_BIT = 1, DATA_BITS = 2, STOP_BIT = 3;

// Registers to hold the current state and the incoming data bits
reg [1:0] state;
reg [7:0] data_bits;
reg [2:0] bit_count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        data_bits <= 0;
        bit_count <= 0;
        done <= 0;
        out_byte <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                // Wait for the start bit (0)
                if (in == 0) begin
                    state <= START_BIT;
                    bit_count <= 0;
                end
            end
            START_BIT: begin
                // Verify that the start bit is valid
                if (in == 0) begin
                    state <= DATA_BITS;
                end
                else begin
                    state <= IDLE;
                end
            end
            DATA_BITS: begin
                // Shift in the data bits
                data_bits <= {data_bits[6:0], in};
                bit_count <= bit_count + 1;
                
                // Once all 8 data bits have been received, wait for the stop bit
                if (bit_count == 7) begin
                    state <= STOP_BIT;
                end
            end
            STOP_BIT: begin
                // Verify the stop bit (1)
                if (in == 1) begin
                    out_byte <= data_bits;
                    done <= 1;
                    state <= IDLE;
                end
                else begin
                    state <= IDLE;
                end
                done <= 0;
            end
        endcase
    end
end

endmodule
