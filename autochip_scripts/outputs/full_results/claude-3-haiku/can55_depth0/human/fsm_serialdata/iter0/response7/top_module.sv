module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam IDLE = 2'b00, START_BIT = 2'b01, DATA_BITS = 2'b10, STOP_BIT = 2'b11;
reg [1:0] state;
reg [3:0] bit_counter;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_counter <= 0;
        data_reg <= 0;
        done <= 0;
        out_byte <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in == 0) // Start bit detected
                    state <= START_BIT;
                bit_counter <= 0;
                data_reg <= 0;
                done <= 0;
            end
            START_BIT: begin
                if (in == 1) // Valid start bit
                    state <= DATA_BITS;
                else // Invalid start bit, stay in IDLE
                    state <= IDLE;
            end
            DATA_BITS: begin
                data_reg[bit_counter] <= in; // Shift in data bit
                bit_counter <= bit_counter + 1;
                if (bit_counter == 8) // All 8 data bits received
                    state <= STOP_BIT;
            end
            STOP_BIT: begin
                if (in == 1) // Valid stop bit
                    begin
                        out_byte <= data_reg;
                        done <= 1;
                        state <= IDLE;
                    end
                else // Invalid stop bit, stay in IDLE
                    state <= IDLE;
            end
        endcase
    end
end

endmodule
