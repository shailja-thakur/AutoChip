module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
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
                if (in == 0) // Start bit detected
                    state <= START;
                else
                    state <= IDLE;
                done <= 0;
            end
            START: begin
                if (bit_count == 0) begin // Wait for start bit
                    if (in == 0)
                        state <= DATA;
                    else
                        state <= ERROR;
                    bit_count <= 1;
                end else begin
                    bit_count <= bit_count + 1;
                    if (bit_count == 9)
                        state <= STOP;
                end
            end
            DATA: begin
                data_reg <= {in, data_reg[7:1]}; // Shift in data bit
                bit_count <= bit_count + 1;
                if (bit_count == 8)
                    state <= STOP;
            end
            STOP: begin
                if (in == 1) begin // Stop bit detected
                    out_byte <= data_reg;
                    done <= 1;
                    state <= IDLE;
                    bit_count <= 0;
                end else
                    state <= ERROR;
            end
            ERROR: begin
                if (in == 1) // Wait for stop bit
                    state <= IDLE;
                else
                    state <= ERROR;
                bit_count <= 0;
            end
        endcase
    end
end

endmodule
