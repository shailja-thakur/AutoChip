module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam [2:0] IDLE = 3'd0,
                 START = 3'd1,
                 DATA = 3'd2,
                 STOP = 3'd3,
                 ERROR = 3'd4;

reg [2:0] state, next_state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        done <= 1'b0;
        bit_count <= 4'd0;
        data_reg <= 8'd0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (in == 1'b0) begin
                next_state = START;
                bit_count = 4'd1;
            end
            else begin
                next_state = IDLE;
                bit_count = 4'd0;
            end
            done = 1'b0;
        end
        START: begin
            if (bit_count == 4'd1) begin
                next_state = DATA;
                bit_count = 4'd1;
            end
            else begin
                next_state = START;
                bit_count = bit_count + 4'd1;
            end
            done = 1'b0;
        end
        DATA: begin
            if (bit_count == 4'd9) begin
                next_state = STOP;
                bit_count = 4'd0;
            end
            else begin
                next_state = DATA;
                bit_count = bit_count + 4'd1;
                data_reg = {in, data_reg[7:1]};
            end
            done = 1'b0;
        end
        STOP: begin
            if (in == 1'b1) begin
                next_state = IDLE;
                done = 1'b1;
            end
            else begin
                next_state = ERROR;
                done = 1'b0;
            end
        end
        ERROR: begin
            if (in == 1'b1) begin
                next_state = IDLE;
                done = 1'b0;
            end
            else begin
                next_state = ERROR;
                done = 1'b0;
            end
        end
        default: begin
            next_state = IDLE;
            done = 1'b0;
        end
    endcase
end

endmodule
