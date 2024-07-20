module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

reg [8:0] state;
reg [7:0] data;
reg [3:0] bit_count;

parameter IDLE = 0;
parameter START = 1;
parameter DATA = 2;
parameter STOP = 3;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        data <= 0;
        bit_count <= 0;
    end else begin
        case(state)
            IDLE: begin
                if (in == 1'b0) begin
                    state <= START;
                    bit_count <= 0;
                end
            end
            
            START: begin
                if (bit_count == 8) begin
                    state <= STOP;
                    bit_count <= 0;
                end else begin
                    data[bit_count] <= in;
                    bit_count <= bit_count + 1;
                end
            end
            
            DATA: begin
                if (bit_count == 8) begin
                    state <= STOP;
                    bit_count <= 0;
                end else begin
                    data[bit_count] <= in;
                    bit_count <= bit_count + 1;
                end
            end
            
            STOP: begin
                if (in == 1'b1) begin
                    out_byte <= data;
                    done <= 1;
                    state <= IDLE;
                end else begin
                    state <= STOP;
                end
            end
        endcase
    end
end

endmodule
