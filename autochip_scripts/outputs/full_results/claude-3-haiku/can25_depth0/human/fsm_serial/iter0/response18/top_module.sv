module top_module(
    input clk,
    input in,
    input reset,
    output reg done
);

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

parameter IDLE = 3'b000;
parameter START_BIT = 3'b001;
parameter DATA_BITS = 3'b010;
parameter STOP_BIT = 3'b011;
parameter WAIT_STOP = 3'b100;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        done <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) // Start bit detected
                    state <= START_BIT;
                else
                    state <= IDLE;
                bit_count <= 0;
                data_reg <= 0;
                done <= 0;
            end
            START_BIT: begin
                if (in == 1'b0) // Start bit is valid
                    state <= DATA_BITS;
                else // Start bit is invalid
                    state <= IDLE;
            end
            DATA_BITS: begin
                data_reg[bit_count] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 4'b1000) // All 8 data bits received
                    state <= STOP_BIT;
            end
            STOP_BIT: begin
                if (in == 1'b1) // Stop bit is valid
                    state <= IDLE;
                else // Stop bit is invalid
                    state <= WAIT_STOP;
                done <= 1'b1;
            end
            WAIT_STOP: begin
                if (in == 1'b1) // Wait for stop bit to become valid
                    state <= IDLE;
                else
                    state <= WAIT_STOP;
                done <= 1'b0;
            end
            default: state <= IDLE;
        endcase
    end
end

endmodule
