module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam  IDLE = 3'b000,
            START_BIT = 3'b001,
            DATA_BITS = 3'b010,
            STOP_BIT = 3'b011,
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
        case (state)
            IDLE:
                if (in == 1'b0)
                    next_state = START_BIT;
                else
                    next_state = IDLE;
            START_BIT:
                next_state = DATA_BITS;
            DATA_BITS:
                if (bit_count == 4'd8)
                    next_state = STOP_BIT;
                else
                    next_state = DATA_BITS;
            STOP_BIT:
                if (in == 1'b1)
                    next_state = IDLE;
                else
                    next_state = ERROR;
            ERROR:
                if (in == 1'b1)
                    next_state = IDLE;
                else
                    next_state = ERROR;
        endcase
    end
end

always @(posedge clk) begin
    case (state)
        IDLE:
            begin
                bit_count <= 0;
                data_reg <= 0;
                done <= 0;
            end
        START_BIT:
            bit_count <= 0;
        DATA_BITS:
            begin
                data_reg <= {data_reg[6:0], in};
                bit_count <= bit_count + 1;
            end
        STOP_BIT:
            begin
                if (in == 1'b1)
                    done <= 1;
                else
                    done <= 0;
            end
        ERROR:
            begin
                bit_count <= 0;
                data_reg <= 0;
                done <= 0;
            end
    endcase
end

endmodule
