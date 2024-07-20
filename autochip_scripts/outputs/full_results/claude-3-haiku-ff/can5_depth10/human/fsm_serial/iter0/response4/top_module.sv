module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

parameter IDLE = 3'd0;
parameter START = 3'd1;
parameter RECEIVE = 3'd2;
parameter STOP = 3'd3;
parameter ERROR = 3'd4;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        done <= 1'b0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    state <= START;
                    bit_count <= 4'b0;
                    data_reg <= 8'b0;
                end
            end
            START: begin
                if (bit_count == 4'd0) begin
                    state <= RECEIVE;
                end else begin
                    bit_count <= bit_count + 1;
                end
            end
            RECEIVE: begin
                data_reg <= {in, data_reg[7:1]};
                bit_count <= bit_count + 1;
                if (bit_count == 4'd8) begin
                    state <= STOP;
                end
            end
            STOP: begin
                if (in == 1'b1) begin
                    done <= 1'b1;
                    state <= IDLE;
                end else begin
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
