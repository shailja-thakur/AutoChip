module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam IDLE = 2'b00;
localparam START_BIT = 2'b01;
localparam DATA_BITS = 2'b10;
localparam STOP_BIT = 2'b11;

reg [1:0] state;
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
                if (in == 1'b0) begin // Start bit detected
                    state <= START_BIT;
                    bit_count <= 0;
                end
            end
            START_BIT: begin
                if (bit_count == 4'd1) begin // Start bit verification
                    if (in == 1'b0) begin
                        state <= DATA_BITS;
                    end else begin
                        state <= IDLE; // Start bit not detected, wait for next byte
                    end
                end
                bit_count <= bit_count + 1;
            end
            DATA_BITS: begin
                data_reg[bit_count-1] <= in; // Shift in data bits
                if (bit_count == 4'd8) begin
                    state <= STOP_BIT;
                    bit_count <= 0;
                end else begin
                    bit_count <= bit_count + 1;
                end
            end
            STOP_BIT: begin
                if (bit_count == 4'd1) begin
                    if (in == 1'b1) begin // Valid stop bit
                        done <= 1'b1;
                        state <= IDLE;
                    end else begin
                        state <= IDLE; // Stop bit not detected, wait for next byte
                    end
                end
                bit_count <= bit_count + 1;
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
