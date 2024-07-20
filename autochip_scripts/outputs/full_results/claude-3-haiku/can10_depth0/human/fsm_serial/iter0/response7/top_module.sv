module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam [1:0] IDLE = 2'b00, START = 2'b01, DATA = 2'b10, STOP = 2'b11;
reg [1:0] state, next_state;
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
        if (state == DATA) begin
            data_reg <= {in, data_reg[7:1]};
            bit_count <= bit_count + 1;
        end
        if (state == STOP && in) begin
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
            if (!in) next_state = START;
        end
        START: begin
            if (in) next_state = DATA;
        end
        DATA: begin
            if (bit_count == 4'd8) next_state = STOP;
        end
        STOP: begin
            if (!in) next_state = IDLE;
        end
    endcase
end

endmodule
