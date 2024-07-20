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
    end
end

always @(*) begin
    next_state = state;
    case (state)
        IDLE: begin
            if (in == 1'b0) // Start bit detected
                next_state = START;
            else
                next_state = IDLE;
        end
        START: begin
            next_state = DATA;
        end
        DATA: begin
            if (bit_count == 4'd8) // All 8 data bits received
                next_state = STOP;
            else
                next_state = DATA;
        end
        STOP: begin
            if (in == 1'b1) // Stop bit detected
                next_state = IDLE;
            else
                next_state = STOP;
        end
        default:
            next_state = IDLE;
    endcase
end

always @(posedge clk) begin
    case (state)
        IDLE: begin
            bit_count <= 0;
            data_reg <= 0;
            done <= 0;
        end
        START: begin
            bit_count <= 0;
        end
        DATA: begin
            data_reg <= {data_reg[6:0], in};
            bit_count <= bit_count + 1;
        end
        STOP: begin
            if (in == 1'b1) begin
                done <= 1;
            end
            else begin
                done <= 0;
            end
        end
        default: begin
            bit_count <= 0;
            data_reg <= 0;
            done <= 0;
        end
    endcase
end

endmodule
