module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam [2:0] IDLE = 3'b000,
                 START = 3'b001,
                 DATA = 3'b010,
                 STOP = 3'b011,
                 ERROR = 3'b100;

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
    end
end

always @(*) begin
    next_state = state;
    case (state)
        IDLE: begin
            if (in == 1'b0) next_state = START;
        end
        START: begin
            if (in == 1'b1) next_state = ERROR;
            else next_state = DATA;
        end
        DATA: begin
            if (bit_count == 4'd8) next_state = STOP;
        end
        STOP: begin
            if (in == 1'b0) next_state = ERROR;
            else begin
                next_state = IDLE;
                done = 1'b1;
            end
        end
        ERROR: begin
            if (in == 1'b1) next_state = IDLE;
        end
    endcase
end

always @(posedge clk) begin
    if (reset) begin
        bit_count <= 0;
        data_reg <= 0;
    end
    else begin
        case (state)
            START: begin
                bit_count <= 0;
            end
            DATA: begin
                data_reg[bit_count] <= in;
                bit_count <= bit_count + 1;
            end
            STOP: begin
                out_byte <= data_reg;
                bit_count <= 0;
                done <= 1'b1;
            end
            IDLE: begin
                done <= 1'b0;
            end
            ERROR: begin
                bit_count <= 0;
            end
        endcase
    end
end

endmodule
