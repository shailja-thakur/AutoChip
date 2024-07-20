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

// Synchronous reset
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        data <= 0;
        start_bit_detected <= 0;
        stop_bit_detected <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 0) begin
                    state <= START_BIT;
                    start_bit_detected <= 1;
                end
            end
            START_BIT: begin
                if (in == 1) begin
                    state <= DATA_BITS;
                    start_bit_detected <= 0;
                end
            end
            DATA_BITS: begin
                data <= {data[6:0], in};
                if (data == 8'b11111110) begin
                    state <= STOP_BIT;
                end
            end
            STOP_BIT: begin
                if (in == 1) begin
                    stop_bit_detected <= 1;
                    state <= IDLE;
                    done <= 1;
                end else begin
                    state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

endmodule
