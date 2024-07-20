module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam IDLE = 2'b00;
localparam WAIT_START = 2'b01;
localparam READ_DATA = 2'b10;
localparam WAIT_STOP = 2'b11;

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
                if (in == 0) begin // Start bit detected
                    state <= WAIT_START;
                    bit_count <= 0;
                end
            end
            WAIT_START: begin
                if (in == 1) begin // Start bit confirmed
                    state <= READ_DATA;
                end
            end
            READ_DATA: begin
                data_reg[bit_count] <= in; // Shift in data bit
                bit_count <= bit_count + 1;
                if (bit_count == 4'b1000) begin // 8 data bits received
                    state <= WAIT_STOP;
                end
            end
            WAIT_STOP: begin
                if (in == 1) begin // Stop bit detected
                    done <= 1'b1;
                    state <= IDLE;
                end else begin
                    done <= 1'b0;
                    state <= IDLE; // Stop bit not detected, wait for next start bit
                end
            end
        endcase
    end
end

endmodule
