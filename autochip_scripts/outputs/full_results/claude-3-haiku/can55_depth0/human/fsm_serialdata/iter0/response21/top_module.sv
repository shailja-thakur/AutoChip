module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam WAIT_START = 2'b00;
localparam RECEIVE_DATA = 2'b01;
localparam VERIFY_STOP = 2'b10;

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
    end
    else begin
        case (state)
            WAIT_START: begin
                if (in == 0) begin // Start bit detected
                    state <= RECEIVE_DATA;
                    bit_count <= 0;
                    data_reg <= 0;
                end
            end
            RECEIVE_DATA: begin
                data_reg[bit_count] <= in; // Shift in data bit
                bit_count <= bit_count + 1;
                if (bit_count == 4'b1000) begin // All 8 data bits received
                    state <= VERIFY_STOP;
                end
            end
            VERIFY_STOP: begin
                if (in == 1) begin // Stop bit detected
                    out_byte <= data_reg;
                    done <= 1;
                end
                else begin
                    done <= 0;
                end
                state <= WAIT_START; // Wait for next start bit
            end
        endcase
    end
end

endmodule
