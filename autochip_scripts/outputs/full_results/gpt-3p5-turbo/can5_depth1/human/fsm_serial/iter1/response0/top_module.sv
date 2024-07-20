module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

reg [2:0] state;
reg previous_bit;
reg start_bit_detected;
reg [7:0] data;
reg stop_bit_detected;

parameter IDLE = 0;
parameter START_BIT = 1;
parameter DATA_BITS = 2;
parameter STOP_BIT = 3;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        previous_bit <= 1; // set previous_bit to 1 when the FSM is reset
    end else begin
        case (state)
            IDLE: begin
                if (in == 0 && previous_bit == 1) begin
                    state <= START_BIT;
                    start_bit_detected <= 1;
                    data <= 0;
                end else begin
                    state <= IDLE;
                    start_bit_detected <= 0;
                    data <= 0;
                end
            end
            START_BIT: begin
                if (in == 0 && previous_bit == 0) begin
                    state <= DATA_BITS;
                    data <= {data[6:0], in};
                end else begin
                    state <= IDLE;
                    start_bit_detected <= 0;
                    data <= 0;
                end
            end
            DATA_BITS: begin
                if (in == 0 && previous_bit == 0) begin
                    state <= DATA_BITS;
                    data <= {data[6:0], in};
                end else begin
                    if (in == 1 && previous_bit == 0) begin
                        state <= STOP_BIT;
                    end else begin
                        state <= IDLE;
                        start_bit_detected <= 0;
                        data <= 0;
                    end
                end
            end
            STOP_BIT: begin
                if (in == 1 && previous_bit == 0) begin
                    state <= IDLE;
                    stop_bit_detected <= 1;
                end else begin
                    state <= IDLE;
                    stop_bit_detected <= 0;
                    data <= 0;
                end
            end
        endcase
        previous_bit <= in;
    end
end

always @(posedge clk) begin
    if (reset) begin
        done <= 0;
    end else begin
        done <= (start_bit_detected && stop_bit_detected);
    end
end

endmodule
