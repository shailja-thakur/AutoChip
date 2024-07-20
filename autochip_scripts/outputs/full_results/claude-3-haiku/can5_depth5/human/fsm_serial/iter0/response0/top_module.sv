module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

// Define the states of the finite state machine
localparam IDLE = 0;
localparam START = 1;
localparam DATA = 2;
localparam STOP = 3;

// Internal registers
reg [3:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                // Wait for the start bit (0)
                if (in == 0) begin
                    state <= START;
                    bit_count <= 0;
                end
            end
            START: begin
                // Wait for the start bit to complete
                if (bit_count == 0) begin
                    state <= DATA;
                    bit_count <= 0;
                end else begin
                    bit_count <= bit_count + 1;
                end
            end
            DATA: begin
                // Shift in the data bits
                data_reg <= {data_reg[6:0], in};
                bit_count <= bit_count + 1;
                if (bit_count == 7) begin
                    state <= STOP;
                    bit_count <= 0;
                end
            end
            STOP: begin
                // Wait for the stop bit (1)
                if (in == 1) begin
                    done <= 1;
                    state <= IDLE;
                end else begin
                    // If the stop bit is not correct, wait for the next start bit
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
