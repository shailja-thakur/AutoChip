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
reg [7:0] data_register;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_register <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 0) begin // Start bit detected
                    state <= START_BIT;
                    bit_count <= 0;
                end
            end
            START_BIT: begin
                if (in == 1) begin // Valid start bit detected
                    state <= DATA_BITS;
                end else begin // Invalid start bit, wait for next
                    state <= IDLE;
                end
            end
            DATA_BITS: begin
                data_register[bit_count] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 4'b1000) begin // 8 data bits received
                    state <= STOP_BIT;
                end
            end
            STOP_BIT: begin
                if (in == 1) begin // Valid stop bit detected
                    done <= 1;
                    state <= IDLE;
                end else begin // Invalid stop bit, wait for next
                    state <= IDLE;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
