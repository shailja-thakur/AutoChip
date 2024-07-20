module top_module (
    input clk,
    input in,
    input reset,
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
                if (bit_count == 4'd9) begin // 1 start bit + 8 data bits
                    if (in == 1'b1) begin // Stop bit detected
                        state <= STOP;
                    end
                    else begin
                        state <= ERROR;
                    end
                end
                else begin
                    data_reg[bit_count] <= in;
                    bit_count <= bit_count + 1;
                end
            end
            STOP: begin
                if (in == 1'b1) begin // Stop bit verified
                    done <= 1'b1;
                    state <= IDLE;
                end
                else begin
                    state <= ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1) begin // Wait for stop bit
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
