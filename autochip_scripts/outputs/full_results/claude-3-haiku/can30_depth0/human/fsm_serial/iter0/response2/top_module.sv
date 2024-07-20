module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam IDLE = 2'b00;
localparam START = 2'b01;
localparam DATA = 2'b10;
localparam STOP = 2'b11;

reg [1:0] state;
reg [2:0] bit_count;
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
                    state <= START;
                    bit_count <= 0;
                end
            end
            START: begin
                bit_count <= bit_count + 1;
                if (bit_count == 3'd7) begin // Wait for 8 data bits
                    state <= DATA;
                    bit_count <= 0;
                end
            end
            DATA: begin
                data_reg <= {in, data_reg[7:1]}; // Shift in data bits
                bit_count <= bit_count + 1;
                if (bit_count == 3'd7) begin // End of data bits
                    state <= STOP;
                end
            end
            STOP: begin
                if (in == 1) begin // Stop bit detected
                    done <= 1;
                    state <= IDLE;
                end else begin
                    state <= IDLE; // Wait for next start bit
                end
            end
        endcase
    end
end

endmodule
