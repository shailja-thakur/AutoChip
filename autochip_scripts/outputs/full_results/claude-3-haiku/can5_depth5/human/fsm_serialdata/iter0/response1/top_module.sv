module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam [1:0] IDLE = 2'b00, START = 2'b01, DATA = 2'b10, STOP = 2'b11;
reg [1:0] state, next_state;
reg [2:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        out_byte <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    next_state <= START;
                    bit_count <= 0;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            START: begin
                if (bit_count == 3'b111) begin // 8 data bits received
                    next_state <= DATA;
                    bit_count <= 0;
                end
                else begin
                    data_reg[bit_count] <= in;
                    bit_count <= bit_count + 1;
                    next_state <= START;
                end
            end
            DATA: begin
                if (bit_count == 3'b000) begin // Stop bit
                    if (in == 1'b1) begin // Valid stop bit
                        out_byte <= data_reg;
                        done <= 1'b1;
                        next_state <= IDLE;
                    end
                    else begin // Invalid stop bit
                        next_state <= IDLE;
                    end
                end
                else begin
                    next_state <= DATA;
                    bit_count <= bit_count - 1;
                end
            end
            default: begin
                next_state <= IDLE;
            end
        endcase
    end
end

endmodule
