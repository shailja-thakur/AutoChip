module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

// Declare states
localparam [2:0] IDLE = 3'd0,
                 START_BIT = 3'd1,
                 DATA_BITS = 3'd2,
                 STOP_BIT = 3'd3,
                 WAIT_STOP = 3'd4;

// Declare registers
reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] shift_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        out_byte <= 0;
        done <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) // Start bit detected
                    state <= START_BIT;
            end
            START_BIT: begin
                if (in == 1'b0) begin // Start bit is valid
                    state <= DATA_BITS;
                    bit_count <= 0;
                end
                else // Start bit not valid, go back to IDLE
                    state <= IDLE;
            end
            DATA_BITS: begin
                shift_reg[bit_count] <= in; // Shift in data bit
                bit_count <= bit_count + 1;
                if (bit_count == 4'd7) // All 8 data bits received
                    state <= STOP_BIT;
            end
            STOP_BIT: begin
                if (in == 1'b1) begin // Stop bit is valid
                    out_byte <= shift_reg;
                    done <= 1'b1;
                    state <= IDLE;
                end
                else // Stop bit not valid, go to WAIT_STOP
                    state <= WAIT_STOP;
            end
            WAIT_STOP: begin
                if (in == 1'b1) // Stop bit detected
                    state <= IDLE;
            end
        endcase
    end
end

endmodule
