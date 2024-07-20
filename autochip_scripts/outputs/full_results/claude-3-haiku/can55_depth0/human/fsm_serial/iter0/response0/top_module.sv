module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam [2:0] IDLE = 3'd0,
                 START_BIT = 3'd1,
                 DATA_BITS = 3'd2,
                 STOP_BIT = 3'd3,
                 ERROR = 3'd4;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        done <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    state <= START_BIT;
                    bit_count <= 0;
                end
                done <= 1'b0;
            end
            START_BIT: begin
                if (in == 1'b0) begin // Start bit still valid
                    state <= DATA_BITS;
                    bit_count <= 1;
                end
                else begin // Start bit not valid
                    state <= ERROR;
                end
            end
            DATA_BITS: begin
                data_reg[bit_count-1] <= in; // Shift in data bit
                if (bit_count == 8) begin
                    state <= STOP_BIT;
                    bit_count <= 0;
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
            STOP_BIT: begin
                if (in == 1'b1) begin // Stop bit valid
                    state <= IDLE;
                    done <= 1'b1;
                end
                else begin // Stop bit not valid
                    state <= ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1) begin // Wait for stop bit
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
