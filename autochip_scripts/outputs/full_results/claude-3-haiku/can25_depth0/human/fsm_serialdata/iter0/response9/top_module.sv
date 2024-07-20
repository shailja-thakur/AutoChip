module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    localparam IDLE = 2'b00;
    localparam START = 2'b01;
    localparam DATA = 2'b10;
    localparam STOP = 2'b11;

    reg [1:0] state;
    reg [3:0] bit_count;
    reg [7:0] data_byte;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 0;
            data_byte <= 0;
            out_byte <= 0;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (in == 1'b0) begin
                        state <= START;
                        bit_count <= 0;
                    end
                end
                START: begin
                    if (in == 1'b1) begin
                        state <= DATA;
                        bit_count <= 0;
                    end else if (in == 1'b0) begin
                        // Wait for start bit
                    end
                end
                DATA: begin
                    data_byte[bit_count] <= in;
                    bit_count <= bit_count + 1;
                    if (bit_count == 4'd7) begin
                        state <= STOP;
                    end
                end
                STOP: begin
                    if (in == 1'b1) begin
                        out_byte <= data_byte;
                        done <= 1'b1;
                        state <= IDLE;
                    end else if (in == 1'b0) begin
                        // Wait for stop bit
                    end
                end
            endcase
        end
    end

endmodule
