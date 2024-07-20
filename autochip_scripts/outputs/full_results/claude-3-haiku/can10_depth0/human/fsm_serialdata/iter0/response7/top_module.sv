module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam IDLE = 2'b00, START = 2'b01, DATA = 2'b10, STOP = 2'b11;
reg [1:0] state;
reg [2:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        done <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in == 0) begin // Start bit detected
                    state <= START;
                    bit_count <= 0;
                end
            end
            START: begin
                if (in == 1) begin // Start bit is valid
                    state <= DATA;
                end
                else begin // Start bit is invalid
                    state <= IDLE;
                end
            end
            DATA: begin
                data_reg[bit_count] <= in; // Shift in data bit
                bit_count <= bit_count + 1;
                if (bit_count == 7) begin // All 8 data bits received
                    state <= STOP;
                end
            end
            STOP: begin
                if (in == 1) begin // Stop bit is valid
                    out_byte <= data_reg;
                    done <= 1;
                    state <= IDLE;
                end
                else begin // Stop bit is invalid
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
