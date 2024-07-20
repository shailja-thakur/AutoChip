module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam IDLE = 2'b00, START = 2'b01, DATA = 2'b10, STOP = 2'b11;
reg [1:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        done <= 0;
        out_byte <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    state <= START;
                    bit_count <= 1; // Start from bit_count 1 instead of 0
                    data_reg <= 0;
                end
                done <= 0;
            end
            START: begin
                if (in == 1'b0) begin // Start bit still valid
                    state <= DATA;
                end
                else begin // Start bit not valid
                    state <= IDLE;
                end
            end
            DATA: begin
                data_reg[bit_count-1] <= in; // Store data bits in the correct order
                bit_count <= bit_count + 1;
                if (bit_count == 4'b1001) begin // 9 bits received (8 data + 1 stop)
                    state <= STOP;
                    bit_count <= 0;
                end
            end
            STOP: begin
                if (in == 1'b1) begin // Stop bit valid
                    out_byte <= data_reg;
                    done <= 1'b1;
                    state <= IDLE;
                end
                else begin // Stop bit not valid
                    state <= IDLE;
                end
            end
            default: state <= IDLE;
        endcase
    end
end

endmodule
