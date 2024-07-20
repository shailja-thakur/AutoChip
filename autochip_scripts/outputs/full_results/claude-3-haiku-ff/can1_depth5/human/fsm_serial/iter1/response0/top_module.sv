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
        if (state == DATA && in == 1'b1) begin
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
            if (bit_count == 3'd0 && in == 1'b1) begin // Stop bit detected
                next_state = IDLE;
            end
            else begin
                next_state = STOP;
            end
        end
        STOP: begin
            if (in == 1'b1) begin // Wait for stop bit to end
                next_state = IDLE;
            end
        end
    endcase
end

endmodule
