module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam IDLE     = 3'd0;
localparam START    = 3'd1;
localparam DATA     = 3'd2;
localparam STOP     = 3'd3;
localparam WAIT_STOP = 3'd4;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_bits;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_bits <= 0;
        out_byte <= 0;
        done <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    state <= START;
                    bit_count <= 0;
                    data_bits <= 0;
                end
            end
            START: begin
                if (bit_count == 4'd1) begin
                    state <= DATA;
                end
                bit_count <= bit_count + 1;
            end
            DATA: begin
                data_bits[bit_count - 1] <= in;
                if (bit_count == 4'd9) begin
                    state <= STOP;
                end
                bit_count <= bit_count + 1;
            end
            STOP: begin
                if (in == 1'b1) begin
                    out_byte <= data_bits;
                    done <= 1'b1;
                    state <= IDLE;
                end
                else begin
                    state <= WAIT_STOP;
                end
            end
            WAIT_STOP: begin
                if (in == 1'b1) begin
                    state <= IDLE;
                    done <= 1'b0;
                end
            end
        endcase
    end
end

endmodule
