module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam IDLE = 0, START = 1, DATA = 2, STOP = 3;
reg [1:0] state;
reg [2:0] bit_count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        out_byte <= 0;
        done <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in == 0) begin // start bit detected
                    state <= START;
                    bit_count <= 0;
                end
            end
            START: begin
                if (bit_count == 0) begin
                    bit_count <= bit_count + 1;
                end
                else if (bit_count == 7) begin
                    state <= DATA;
                    bit_count <= 0;
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
            DATA: begin
                if (bit_count == 0) begin
                    out_byte[0] <= in;
                end
                else if (bit_count == 7) begin
                    state <= STOP;
                    bit_count <= 0;
                end
                else begin
                    out_byte <= {in, out_byte[7:1]};
                    bit_count <= bit_count + 1;
                end
            end
            STOP: begin
                if (in == 1) begin
                    done <= 1;
                    state <= IDLE;
                end
                else begin
                    done <= 0;
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
