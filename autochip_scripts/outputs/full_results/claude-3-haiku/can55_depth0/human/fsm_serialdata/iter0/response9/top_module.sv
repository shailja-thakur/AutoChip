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
reg [2:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        out_byte <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        if (state == DATA) begin
            data_reg <= {in, data_reg[7:1]};
            bit_count <= bit_count + 1;
        end
        if (state == STOP && in == 1) begin
            out_byte <= data_reg;
            done <= 1;
        end
        else begin
            done <= 0;
        end
    end
end

always @(*) begin
    next_state = state;
    case (state)
        IDLE: begin
            if (in == 0)
                next_state = START;
        end
        START: begin
            next_state = DATA;
        end
        DATA: begin
            if (bit_count == 3'd7)
                next_state = STOP;
        end
        STOP: begin
            if (in == 1)
                next_state = IDLE;
        end
        default:
            next_state = IDLE;
    endcase
end

endmodule
