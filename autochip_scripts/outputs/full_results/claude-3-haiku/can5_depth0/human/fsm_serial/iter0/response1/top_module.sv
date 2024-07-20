module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam IDLE = 2'd0;
localparam START = 2'd1;
localparam DATA = 2'd2;
localparam STOP = 2'd3;

reg [1:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    state <= START;
                    bit_count <= 0;
                end
            end
            START: begin
                if (in == 1'b0) begin
                    state <= DATA;
                    bit_count <= 0;
                end else begin
                    state <= IDLE; // Start bit not detected, wait for next start bit
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
                end else begin
                    state <= IDLE; // Stop bit not detected, wait for next start bit
                end
            end
        endcase
    end
end

endmodule
