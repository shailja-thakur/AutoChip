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

reg [1:0] state, next_state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk or posedge reset) begin
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
                if (in == 0) begin
                    next_state <= START;
                    bit_count <= 0;
                end
                else begin
                    next_state <= IDLE;
                end
                done <= 0;
            end
            START: begin
                if (in == 0) begin
                    next_state <= DATA;
                    bit_count <= 0;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            DATA: begin
                data_reg[bit_count] <= in;
                if (bit_count == 4'd7) begin
                    next_state <= STOP;
                end
                else begin
                    next_state <= DATA;
                    bit_count <= bit_count + 1;
                end
            end
            STOP: begin
                if (in == 1) begin
                    next_state <= IDLE;
                    out_byte <= data_reg;
                    done <= 1;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            default: begin
                next_state <= IDLE;
            end
        endcase
    end
end

endmodule
