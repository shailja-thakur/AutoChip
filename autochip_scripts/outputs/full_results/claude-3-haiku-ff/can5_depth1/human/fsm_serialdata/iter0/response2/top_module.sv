module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

// Define the states of the FSM
localparam [2:0] IDLE = 3'b000,
                 START_BIT = 3'b001,
                 DATA_BITS = 3'b010,
                 STOP_BIT = 3'b011,
                 WAIT_STOP = 3'b100;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        out_byte <= 0;
        done <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in == 0) begin // Start bit detected
                    state <= START_BIT;
                    bit_count <= 0;
                    data_reg <= 0;
                end
            end
            START_BIT: begin
                if (in == 0) begin // Valid start bit
                    state <= DATA_BITS;
                end
                else begin // Invalid start bit, go back to IDLE
                    state <= IDLE;
                end
            end
            DATA_BITS: begin
                data_reg[bit_count] <= in; // Shift in data bit
                bit_count <= bit_count + 1;
                if (bit_count == 7) begin // All 8 data bits received
                    state <= STOP_BIT;
                end
            end
            STOP_BIT: begin
                if (in == 1) begin // Valid stop bit
                    out_byte <= data_reg;
                    done <= 1;
                    state <= IDLE;
                end
                else begin // Invalid stop bit, wait for next stop bit
                    state <= WAIT_STOP;
                end
            end
            WAIT_STOP: begin
                if (in == 1) begin // Valid stop bit found
                    state <= IDLE;
                    done <= 1;
                end
            end
        endcase
    end
end

endmodule
