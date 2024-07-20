module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam [2:0] IDLE = 3'b000,
                 START = 3'b001,
                 DATA = 3'b010,
                 STOP = 3'b011,
                 ERROR = 3'b100;

reg [2:0] state;
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
        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    state <= START;
                    bit_count <= 0;
                end
            end
            START: begin
                if (in == 1'b0) begin
                    state <= DATA;
                    bit_count <= 0;
                end
                else begin
                    state <= ERROR;
                end
            end
            DATA: begin
                data_reg[bit_count] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 4'd7) begin
                    state <= STOP;
                end
            end
            STOP: begin
                if (in == 1'b1) begin
                    done <= 1'b1;
                    state <= IDLE;
                end
                else begin
                    state <= ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1) begin
                    state <= IDLE;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
