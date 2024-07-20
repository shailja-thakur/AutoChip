module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam [2:0] IDLE = 3'b000, START = 3'b001, DATA = 3'b010, STOP = 3'b011;
reg [2:0] state, next_state;
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
        state <= next_state;
        case (state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    next_state <= START;
                    bit_count <= 0;
                    data_reg <= 0;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            START: begin
                if (bit_count == 4'd9) begin // 8 data bits + 1 stop bit
                    if (in == 1'b1) begin // Stop bit is correct
                        next_state <= IDLE;
                        out_byte <= data_reg;
                        done <= 1'b1;
                    end
                    else begin // Stop bit is incorrect
                        next_state <= IDLE;
                        done <= 1'b0;
                    end
                end
                else begin
                    data_reg[bit_count] <= in; // Shift in data bit
                    bit_count <= bit_count + 1'b1;
                    next_state <= DATA;
                end
            end
            DATA: begin
                if (bit_count == 4'd8) begin
                    next_state <= STOP;
                end
                else begin
                    data_reg[bit_count] <= in; // Shift in data bit
                    bit_count <= bit_count + 1'b1;
                    next_state <= DATA;
                end
            end
            STOP: begin
                if (in == 1'b1) begin // Stop bit is correct
                    next_state <= IDLE;
                    done <= 1'b1;
                end
                else begin // Stop bit is incorrect
                    next_state <= IDLE;
                    done <= 1'b0;
                end
            end
            default: begin
                next_state <= IDLE;
            end
        endcase
    end
end

endmodule
