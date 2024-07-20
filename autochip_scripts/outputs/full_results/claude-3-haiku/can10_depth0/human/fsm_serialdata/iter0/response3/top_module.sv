module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam IDLE = 2'b00;
localparam START = 2'b01;
localparam DATA = 2'b10;
localparam STOP = 2'b11;

reg [1:0] state;
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
                    state <= START;
                    bit_count <= 0;
                end
            end
            START: begin
                if (bit_count == 4'd9) begin // Data bits and stop bit received
                    if (in == 1'b1) begin // Stop bit correct
                        out_byte <= data_reg;
                        done <= 1'b1;
                        state <= IDLE;
                    end
                    else begin // Stop bit incorrect
                        state <= IDLE;
                    end
                end
                else begin
                    bit_count <= bit_count + 1'b1;
                    data_reg <= {data_reg[6:0], in};
                    if (bit_count == 4'd8) begin
                        state <= STOP;
                    end
                end
            end
            STOP: begin
                if (in == 1'b1) begin
                    state <= IDLE;
                    done <= 1'b0;
                end
            end
        endcase
    end
end

endmodule
