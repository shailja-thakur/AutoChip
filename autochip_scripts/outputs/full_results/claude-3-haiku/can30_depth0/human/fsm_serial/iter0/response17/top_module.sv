module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam WAIT_START = 0;
localparam READ_DATA  = 1;
localparam WAIT_STOP  = 2;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        bit_count <= 0;
        data_reg <= 0;
        done <= 0;
    end else begin
        case (state)
            WAIT_START: begin
                if (in == 0) begin // Start bit detected
                    state <= READ_DATA;
                    bit_count <= 0;
                    data_reg <= 0;
                end
            end
            READ_DATA: begin
                data_reg[bit_count] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 7) begin
                    state <= WAIT_STOP;
                end
            end
            WAIT_STOP: begin
                if (in == 1) begin // Stop bit detected
                    done <= 1;
                    state <= WAIT_START;
                end else begin
                    done <= 0;
                end
            end
        endcase
    end
end

endmodule
