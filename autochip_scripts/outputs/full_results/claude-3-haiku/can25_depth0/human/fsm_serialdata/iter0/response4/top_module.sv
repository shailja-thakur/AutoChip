module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam IDLE = 3'b000;
localparam START = 3'b001;
localparam DATA = 3'b010;
localparam STOP = 3'b011;
localparam ERROR = 3'b100;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        done <= 0;
        out_byte <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 0) begin // Start bit detected
                    state <= START;
                    bit_count <= 0;
                    data_reg <= 0;
                end
            end
            START: begin
                if (bit_count == 0) begin
                    if (in == 0) begin // Correct start bit
                        state <= DATA;
                        bit_count <= 1;
                    end else begin // Incorrect start bit
                        state <= ERROR;
                    end
                end else if (bit_count == 8) begin
                    state <= STOP;
                    bit_count <= 0;
                end else begin
                    bit_count <= bit_count + 1;
                    data_reg[bit_count-1] <= in;
                end
            end
            DATA: begin
                if (bit_count == 8) begin
                    state <= STOP;
                    bit_count <= 0;
                end else begin
                    bit_count <= bit_count + 1;
                    data_reg[bit_count-1] <= in;
                end
            end
            STOP: begin
                if (in == 1) begin // Correct stop bit
                    state <= IDLE;
                    out_byte <= data_reg;
                    done <= 1;
                end else begin // Incorrect stop bit
                    state <= ERROR;
                end
            end
            ERROR: begin
                if (in == 1) begin // Wait for stop bit
                    state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

endmodule
