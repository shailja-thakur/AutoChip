module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

reg [3:0] state;

parameter IDLE = 2'd0;
parameter START = 2'd1;
parameter DATA = 2'd2;
parameter STOP = 2'd3;

reg [2:0] count;
reg start_bit_detected;
reg [7:0] data_bits;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        count <= 3'd0;
        start_bit_detected <= 1'b0;
        data_bits <= 8'd0;
        out_byte <= 8'd0;
        done <= 1'b0;
    end else begin
        case (state)
            IDLE: begin
                if (in) begin
                    state <= START;
                    start_bit_detected <= 1'b1;
                    count <= 3'd0;
                    data_bits <= 8'd0;
                end else begin
                    state <= IDLE;
                end
            end
            
            START: begin
                if (start_bit_detected && !in) begin
                    state <= DATA;
                end else if (start_bit_detected && in) begin
                    state <= START;
                end else begin
                    state <= IDLE;
                end
            end
            
            DATA: begin
                if (count < 8) begin
                    data_bits[count] <= in;
                    count <= count + 1;
                    state <= DATA;
                end else begin
                    state <= STOP;
                end
            end
            
            STOP: begin
                if (count < 8) begin
                    state <= STOP;
                end else if (count == 8 && in) begin
                    state <= IDLE;
                    done <= 1'b1;
                    out_byte <= data_bits;
                end else begin
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
