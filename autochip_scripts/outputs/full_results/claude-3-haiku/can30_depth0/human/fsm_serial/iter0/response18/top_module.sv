module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam [2:0] IDLE = 3'b000, START = 3'b001, DATA = 3'b010, STOP = 3'b011, ERROR = 3'b100;
reg [2:0] state;
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
                    state <= START;
                    bit_count <= 0;
                end
            end
            START: begin
                if (bit_count == 4'd9) begin // 9 bits received (start + 8 data)
                    if (in == 1'b1) begin // Stop bit is valid
                        state <= STOP;
                    end else begin // Stop bit is invalid
                        state <= ERROR;
                    end
                end else begin
                    bit_count <= bit_count + 1;
                    data_reg[bit_count-1] <= in; // Shift in data bits
                end
            end
            STOP: begin
                done <= 1'b1; // Indicate byte received successfully
                state <= IDLE;
            end
            ERROR: begin
                while (in == 1'b0) begin // Wait for stop bit
                    bit_count <= bit_count + 1;
                end
                state <= IDLE;
            end
        endcase
    end
end

endmodule
