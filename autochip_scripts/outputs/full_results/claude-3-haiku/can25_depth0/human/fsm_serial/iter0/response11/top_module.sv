module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam [1:0] IDLE = 2'b00, START = 2'b01, DATA = 2'b10, STOP = 2'b11;
reg [1:0] state;
reg [2:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        done <= 0;
        bit_count <= 0;
        data_reg <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in == 0) begin
                    state <= START;
                    bit_count <= 0;
                end
            end
            START: begin
                if (bit_count == 3'b000) begin
                    if (in == 0) begin
                        state <= DATA;
                    end
                    else begin
                        state <= IDLE; // Incorrect start bit
                    end
                end
                bit_count <= bit_count + 1;
            end
            DATA: begin
                data_reg[bit_count] <= in;
                if (bit_count == 3'b111) begin
                    state <= STOP;
                    bit_count <= 0;
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
            STOP: begin
                if (bit_count == 3'b000) begin
                    if (in == 1) begin
                        done <= 1;
                        state <= IDLE;
                    end
                    else begin
                        state <= IDLE; // Incorrect stop bit
                    end
                end
                bit_count <= bit_count + 1;
            end
        endcase
    end
end

endmodule
