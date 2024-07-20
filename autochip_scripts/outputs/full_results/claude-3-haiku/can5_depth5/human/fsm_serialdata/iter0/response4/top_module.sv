module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

parameter IDLE = 3'b000;
parameter START_BIT = 3'b001;
parameter DATA_BITS = 3'b010;
parameter STOP_BIT = 3'b011;
parameter WAIT_STOP = 3'b100;

reg [2:0] state, next_state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        out_byte <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        IDLE: begin
            if (in == 0) begin // Start bit detected
                next_state = START_BIT;
                bit_count = 0;
                data_reg = 0;
            end
        end
        START_BIT: begin
            if (in == 1) begin // Valid start bit
                next_state = DATA_BITS;
            end
            else begin // Invalid start bit
                next_state = IDLE;
            end
        end
        DATA_BITS: begin
            data_reg = {in, data_reg[7:1]}; // Shift in data bit
            bit_count = bit_count + 1;
            if (bit_count == 8) begin
                next_state = STOP_BIT;
            end
        end
        STOP_BIT: begin
            if (in == 1) begin // Valid stop bit
                out_byte = data_reg;
                done = 1;
                next_state = IDLE;
            end
            else begin // Invalid stop bit
                next_state = WAIT_STOP;
            end
        end
        WAIT_STOP: begin
            if (in == 1) begin
                next_state = IDLE;
                done = 0;
            end
        end
    endcase
end

endmodule
