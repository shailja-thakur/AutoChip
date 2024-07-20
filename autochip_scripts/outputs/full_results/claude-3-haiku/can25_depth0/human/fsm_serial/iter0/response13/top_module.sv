module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam [1:0] IDLE = 2'b00, START = 2'b01, DATA = 2'b10, STOP = 2'b11;
reg [1:0] state, next_state;
reg [2:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        done <= 0;
    end else begin
        state <= next_state;
        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state <= START;
                    bit_count <= 0;
                end else begin
                    next_state <= IDLE;
                end
            end
            START: begin
                if (bit_count == 3'd1) begin
                    next_state <= DATA;
                    bit_count <= 0;
                end else begin
                    next_state <= START;
                    bit_count <= bit_count + 1;
                end
            end
            DATA: begin
                data_reg[bit_count] <= in;
                if (bit_count == 3'd7) begin
                    next_state <= STOP;
                    bit_count <= 0;
                end else begin
                    next_state <= DATA;
                    bit_count <= bit_count + 1;
                end
            end
            STOP: begin
                if (in == 1'b1) begin
                    next_state <= IDLE;
                    done <= 1'b1;
                end else begin
                    next_state <= STOP;
                end
            end
            default: begin
                next_state <= IDLE;
            end
        endcase
    end
end

endmodule
