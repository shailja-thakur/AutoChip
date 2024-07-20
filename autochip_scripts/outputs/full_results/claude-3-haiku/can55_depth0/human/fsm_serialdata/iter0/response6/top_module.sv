module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam IDLE = 3'b000, START = 3'b001, DATA = 3'b010, STOP = 3'b011, ERR = 3'b100;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_register;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_register <= 0;
        done <= 0;
        out_byte <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 0) begin
                    state <= START;
                    bit_count <= 0;
                end
            end
            START: begin
                if (in == 1) begin
                    state <= ERROR;
                end else begin
                    state <= DATA;
                end
            end
            DATA: begin
                data_register[bit_count] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 4'b1000) begin
                    state <= STOP;
                end
            end
            STOP: begin
                if (in == 1) begin
                    state <= IDLE;
                    done <= 1;
                    out_byte <= data_register;
                end else begin
                    state <= ERROR;
                end
            end
            ERROR: begin
                if (in == 1) begin
                    state <= IDLE;
                    done <= 0;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
