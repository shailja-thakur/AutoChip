module top_module (
    input clk,
    input in,
    input reset,
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
        done <= 0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        IDLE: begin
            if (in == 1'b0) begin // Start bit detected
                next_state = START;
                bit_count = 0;
                data_reg = 0;
            end
        end
        START: begin
            if (bit_count == 3'd7) begin // 8 data bits received
                next_state = DATA;
            end
            else begin
                bit_count = bit_count + 1;
                data_reg = {data_reg[6:0], in};
            end
        end
        DATA: begin
            if (in == 1'b1) begin // Stop bit detected
                next_state = STOP;
                done = 1;
            end
            else begin
                next_state = IDLE;
                done = 0;
            end
        end
        STOP: begin
            next_state = IDLE;
            done = 0;
        end
    endcase
end

endmodule
