module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

parameter IDLE = 3'b000, START = 3'b001, DATA = 3'b010, STOP = 3'b011, ERROR = 3'b100;
reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
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
                    state <= START;
                else
                    state <= IDLE;
            end
            START: begin
                if (in == 1'b0) // Valid start bit
                    state <= DATA;
                else // Start bit error
                    state <= ERROR;
                bit_count <= 0;
            end
            DATA: begin
                data_reg[bit_count] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 4'd7) // All 8 data bits received
                    state <= STOP;
                else
                    state <= DATA;
            end
            STOP: begin
                if (in == 1'b1) // Valid stop bit
                    state <= IDLE;
                else // Stop bit error
                    state <= ERROR;
                done <= 1'b1;
            end
            ERROR: begin
                // Wait until a stop bit is detected
                if (in == 1'b1)
                    state <= IDLE;
                else
                    state <= ERROR;
                done <= 1'b0;
            end
        endcase
    end
end

endmodule
