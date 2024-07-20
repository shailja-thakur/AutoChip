module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

// Define the states of the finite state machine
parameter IDLE = 0, START = 1, DATA = 2, STOP = 3;

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
    end
    else begin
        case (state)
            IDLE: begin
                // Wait for the start bit (0)
                if (in == 0) begin
                    state <= START;
                    bit_count <= 0;
                end
            end
            START: begin
                // Receive the 8 data bits
                data_reg[bit_count] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 8) begin
                    state <= STOP;
                end
            end
            STOP: begin
                // Verify the stop bit (1)
                if (in == 1) begin
                    done <= 1;
                    state <= IDLE;
                end
                else begin
                    // Wait until a stop bit is received
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
