module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

reg [3:0] state;
reg [2:0] count;
reg start_bit_detected;
reg [7:0] data_bit;
reg stop_bit_detected;
reg [7:0] temp_byte;

parameter IDLE = 0, START_BIT = 1, DATA_BITS = 2, STOP_BIT = 3;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        count <= 0;
        out_byte <= 0;
        done <= 0;
        start_bit_detected <= 0;
        data_bit <= 0;
        stop_bit_detected <= 0;
        temp_byte <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 1) begin
                    start_bit_detected <= 1;
                    state <= START_BIT;
                    count <= 0;
                    data_bit <= in;
                end
            end

            START_BIT: begin
                if (in == 1) begin
                    start_bit_detected <= 0;
                    state <= DATA_BITS;
                end else begin
                    data_bit <= in;
                end
            end

            DATA_BITS: begin
                if (count < 8) begin
                    data_bit <= in;
                    count <= count + 1;
                end else begin
                    state <= STOP_BIT;
                end
            end

            STOP_BIT: begin
                if (in == 1) begin
                    stop_bit_detected <= 1;
                    temp_byte <= {data_bit[6:0], in};
                    state <= IDLE;
                    out_byte <= temp_byte;
                    done <= 1;
                end
            end
        endcase
    end
end

endmodule
