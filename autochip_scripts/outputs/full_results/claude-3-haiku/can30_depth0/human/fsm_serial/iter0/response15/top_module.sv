module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam IDLE = 2'b00;
localparam START = 2'b01;
localparam DATA = 2'b10;
localparam STOP = 2'b11;

reg [1:0] state, next_state;
reg [3:0] bit_count;
reg [7:0] data_register;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_register <= 0;
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
            if (in == 1'b0) begin
                next_state = START;
                bit_count = 0;
                data_register = 0;
            end
        end
        START: begin
            if (bit_count == 4'd0) begin
                if (in == 1'b0) begin
                    next_state = DATA;
                end
                else begin
                    next_state = IDLE;
                end
            end
            bit_count = bit_count + 1;
        end
        DATA: begin
            data_register = {in, data_register[7:1]};
            bit_count = bit_count + 1;
            if (bit_count == 4'd9) begin
                next_state = STOP;
            end
        end
        STOP: begin
            if (in == 1'b1) begin
                done = 1'b1;
                next_state = IDLE;
            end
            else begin
                next_state = IDLE;
            end
        end
    endcase
end

endmodule
