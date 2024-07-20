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

reg [1:0] state, next_state;
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
        state <= next_state;
        if (state == DATA) begin
            data_reg[bit_count] <= in;
            bit_count <= bit_count + 1;
        end
        if (state == STOP) begin
            if (in == 1) begin
                done <= 1;
                out_byte <= data_reg;
            end
            else begin
                done <= 0;
            end
            bit_count <= 0;
        end
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (in == 0) begin
                next_state = START;
            end
            else begin
                next_state = IDLE;
            end
        end
        START: begin
            next_state = DATA;
        end
        DATA: begin
            if (bit_count == 4'd8) begin
                next_state = STOP;
            end
            else begin
                next_state = DATA;
            end
        end
        STOP: begin
            if (in == 1) begin
                next_state = IDLE;
            end
            else begin
                next_state = STOP;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
