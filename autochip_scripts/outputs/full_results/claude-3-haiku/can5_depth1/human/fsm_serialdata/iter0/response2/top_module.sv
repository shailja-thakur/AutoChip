module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam [1:0] WAIT_START = 2'b00,
                 RECEIVE_DATA = 2'b01,
                 WAIT_STOP = 2'b10;

reg [1:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        bit_count <= 0;
        data_reg <= 0;
        done <= 0;
        out_byte <= 0;
    end else begin
        case (state)
            WAIT_START: begin
                if (in == 1'b0) begin // Start bit detected
                    state <= RECEIVE_DATA;
                    bit_count <= 0;
                    data_reg <= 0;
                end
            end
            RECEIVE_DATA: begin
                data_reg[bit_count] <= in; // Shift in data bit
                bit_count <= bit_count + 1;
                if (bit_count == 4'b1000) begin // 8 data bits received
                    state <= WAIT_STOP;
                end
            end
            WAIT_STOP: begin
                if (in == 1'b1) begin // Stop bit detected
                    done <= 1'b1;
                    out_byte <= data_reg;
                    state <= WAIT_START;
                end else begin
                    done <= 1'b0;
                end
            end
        endcase
    end
end

endmodule
