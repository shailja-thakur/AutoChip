module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

// Define the states of the finite state machine
localparam [2:0] IDLE       = 3'b000,
                 START_BIT  = 3'b001,
                 DATA_BITS  = 3'b010,
                 STOP_BIT   = 3'b011,
                 WAIT_STOP  = 3'b100;

// Internal registers
reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (~in) // Start bit detected
                    state <= START_BIT;
                bit_count <= 0;
                data_reg <= 0;
                done <= 0;
            end
            START_BIT: begin
                if (~in) // Start bit is valid
                    state <= DATA_BITS;
                else // Start bit not valid, wait for next start bit
                    state <= IDLE;
                bit_count <= 0;
            end
            DATA_BITS: begin
                data_reg[bit_count] <= in; // Shift in data bit
                bit_count <= bit_count + 1;
                if (bit_count == 4'b1000) // 8 data bits received
                    state <= STOP_BIT;
            end
            STOP_BIT: begin
                if (in) // Stop bit is valid
                    state <= IDLE;
                else // Stop bit not valid, wait for next stop bit
                    state <= WAIT_STOP;
                done <= 1; // Signal that a byte has been received
            end
            WAIT_STOP: begin
                if (in) // Stop bit is now valid
                    state <= IDLE;
            end
        endcase
    end
end

endmodule
