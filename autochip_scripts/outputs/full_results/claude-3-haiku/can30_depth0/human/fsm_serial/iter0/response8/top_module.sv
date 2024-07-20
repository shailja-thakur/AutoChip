module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam IDLE = 0, START = 1, DATA = 2, STOP = 3;
reg [2:0] state, next_state;
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
        state <= next_state;

        case (state)
            IDLE: begin
                if (in == 0) // Start bit detected
                    next_state <= START;
                else
                    next_state <= IDLE;
                bit_count <= 0;
                data_reg <= 0;
                done <= 0;
            end
            START: begin
                if (in == 0) // Start bit must be 0
                    next_state <= DATA;
                else
                    next_state <= IDLE; // Start bit error, return to IDLE
                bit_count <= 0;
            end
            DATA: begin
                data_reg[bit_count] <= in; // Store data bit
                if (bit_count == 7) // All 8 data bits received
                    next_state <= STOP;
                else
                    next_state <= DATA;
                bit_count <= bit_count + 1;
            end
            STOP: begin
                if (in == 1) // Stop bit must be 1
                    next_state <= IDLE;
                else
                    next_state <= IDLE; // Stop bit error, return to IDLE
                done <= 1; // Byte received successfully
            end
        endcase
    end
end

endmodule
