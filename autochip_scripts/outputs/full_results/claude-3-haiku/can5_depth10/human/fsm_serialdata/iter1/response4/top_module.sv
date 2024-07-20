module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam IDLE = 2'b00, START = 2'b01, DATA = 2'b10, STOP = 2'b11;
reg [1:0] state, next_state;
reg [3:0] bit_count;
reg [7:0] data_buffer;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_buffer <= 0;
        out_byte <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;

        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state <= START;
                    bit_count <= 0;
                    data_buffer <= 0;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            START: begin
                if (in == 1'b0) begin
                    next_state <= DATA;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            DATA: begin
                data_buffer[bit_count] <= in;
                if (bit_count == 4'd7) begin
                    next_state <= STOP;
                end
                else begin
                    bit_count <= bit_count + 1;
                    next_state <= DATA;
                end
            end
            STOP: begin
                if (in == 1'b1) begin
                    out_byte <= data_buffer;
                    done <= 1'b1;
                    next_state <= IDLE;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            default: begin
                next_state <= IDLE;
            end
        endcase

        if (state == STOP && in == 1'b1) begin
            done <= 1'b1;
        end
        else begin
            done <= 1'b0;
        end
    end
end

endmodule
