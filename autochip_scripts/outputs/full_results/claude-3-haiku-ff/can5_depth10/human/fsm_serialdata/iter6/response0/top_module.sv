module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam IDLE = 2'b00;
localparam START = 2'b01;
localparam RECEIVE = 2'b10;
localparam STOP = 2'b11;

reg [1:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        done <= 0;
        out_byte <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                done <= 0;
                if (in == 0) begin
                    state <= START;
                    bit_count <= 0;
                end
            end
            
            START: begin
                if (in == 0) begin
                    state <= RECEIVE;
                    bit_count <= 1;
                end
                else begin
                    state <= IDLE;
                end
            end
            
            RECEIVE: begin
                data_reg[bit_count-1] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 9) begin
                    state <= STOP;
                end
            end
            
            STOP: begin
                if (in == 1) begin
                    out_byte <= data_reg;
                    done <= 1;
                    state <= IDLE;
                end
                else begin
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
