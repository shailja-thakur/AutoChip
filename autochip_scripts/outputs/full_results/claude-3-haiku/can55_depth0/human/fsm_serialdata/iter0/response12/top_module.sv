module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

parameter IDLE = 2'b00;
parameter START = 2'b01;
parameter DATA = 2'b10;
parameter STOP = 2'b11;

reg [1:0] state;
reg [2:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        out_byte <= 0;
        done <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in == 0) // Start bit detected
                    state <= START;
            end
            START: begin
                bit_count <= 0;
                state <= DATA;
            end
            DATA: begin
                data_reg <= {in, data_reg[7:1]}; // Shift in data bit
                bit_count <= bit_count + 1;
                if (bit_count == 7)
                    state <= STOP;
            end
            STOP: begin
                if (in == 1) begin // Stop bit detected
                    out_byte <= data_reg;
                    done <= 1;
                    state <= IDLE;
                end
                else begin // No stop bit
                    state <= IDLE;
                end
                bit_count <= 0;
            end
        endcase
    end
end

endmodule
