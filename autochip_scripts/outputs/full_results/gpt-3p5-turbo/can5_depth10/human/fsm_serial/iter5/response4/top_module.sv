module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

// Define states
localparam IDLE = 2'b00;
localparam START_BIT = 2'b01;
localparam DATA_BITS = 2'b10;
localparam STOP_BIT = 2'b11;

// Define signals
reg [1:0] state;
reg [7:0] data;
reg start_bit_detected;
reg stop_bit_detected;
reg [2:0] bit_counter;

// Synchronous reset
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        data <= 0;
        start_bit_detected <= 0;
        stop_bit_detected <= 0;
        bit_counter <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 0) begin
                    state <= START_BIT;
                    bit_counter <= 0;
                end
            end
            START_BIT: begin
                if (bit_counter == 8) begin
                    state <= STOP_BIT;
                    bit_counter <= 0;
                    start_bit_detected <= 1;
                end else begin
                    state <= DATA_BITS;
                    bit_counter <= bit_counter + 1;
                    data <= {data[6:0], in};
                end
            end
            DATA_BITS: begin
                if (bit_counter == 8) begin
                    state <= STOP_BIT;
                    bit_counter <= 0;
                end else begin
                    state <= DATA_BITS;
                    bit_counter <= bit_counter + 1;
                    data <= {data[6:0], in};
                end
            end
            STOP_BIT: begin
                if (in == 1) begin
                    stop_bit_detected <= 1;
                    state <= IDLE;
                    done <= 1;
                end else begin
                    state <= DATA_BITS;
                    bit_counter <= 0;
                end
            end
        endcase
    end
end

endmodule
