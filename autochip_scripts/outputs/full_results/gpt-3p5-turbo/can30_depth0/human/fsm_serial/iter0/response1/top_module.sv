module top_module (
    input clk,
    input in,
    input reset,
    output done
);

reg [2:0] state;
reg start_bit_detected;
reg [7:0] data_bits;
reg stop_bit_detected;

parameter IDLE = 3'b000;
parameter START_BIT = 3'b001;
parameter DATA_BITS = 3'b010;
parameter STOP_BIT = 3'b011;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        start_bit_detected <= 0;
        data_bits <= 0;
        stop_bit_detected <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    state <= START_BIT;
                    start_bit_detected <= 1;
                    data_bits <= 0;
                    stop_bit_detected <= 0;
                end
            end
            START_BIT: begin
                if (in == 1'b0) begin
                    state <= DATA_BITS;
                end else begin
                    state <= IDLE;
                end
            end
            DATA_BITS: begin
                if (in == 1'b0) begin
                    if (start_bit_detected) begin
                        data_bits <= {in, data_bits[7:1]};
                    end
                end else begin
                    state <= STOP_BIT;
                end
            end
            STOP_BIT: begin
                if (in == 1'b1) begin
                    stop_bit_detected <= 1;
                    if (start_bit_detected && stop_bit_detected) begin
                        done <= 1;
                    end
                    state <= IDLE;
                end
            end
            default: state <= IDLE;
        endcase
    end
end

endmodule
