module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

reg [2:0] state;
reg [7:0] data_byte;
reg start_bit_detected;
reg [2:0] bit_counter;
reg [1:0] stop_bit_counter;

parameter IDLE = 3'b000;
parameter START_BIT = 3'b001;
parameter DATA_BIT = 3'b010;
parameter STOP_BIT = 3'b011;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        data_byte <= 8'b0;
        start_bit_detected <= 0;
        bit_counter <= 0;
        stop_bit_counter <= 0;
        out_byte <= 8'b0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    start_bit_detected <= 1;
                    bit_counter <= 0;
                    data_byte <= 8'b0;
                    state <= START_BIT;
                end
            end
            START_BIT: begin
                // Receive data bits
                data_byte[bit_counter] <= in;
                bit_counter <= bit_counter + 1;
                if (bit_counter == 7) begin
                    state <= STOP_BIT;
                end else begin
                    state <= DATA_BIT;
                end
            end
            DATA_BIT: begin
                // Receive data bits
                data_byte[bit_counter] <= in;
                bit_counter <= bit_counter + 1;
                if (bit_counter == 7) begin
                    state <= STOP_BIT;
                end
            end
            STOP_BIT: begin
                // Verify stop bit
                if (in == 1'b1) begin
                    stop_bit_counter <= stop_bit_counter + 1;
                    if (stop_bit_counter == 1) begin
                        out_byte <= data_byte;
                        done <= 1;
                    end
                    state <= IDLE;
                end else begin
                    state <= STOP_BIT;
                end
            end
        endcase
    end
end

endmodule
