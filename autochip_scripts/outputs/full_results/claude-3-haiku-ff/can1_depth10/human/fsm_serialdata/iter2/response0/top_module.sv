module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam IDLE = 3'b000;
localparam START_BIT = 3'b001;
localparam DATA_BITS = 3'b010;
localparam STOP_BIT = 3'b011;
localparam WAIT_STOP = 3'b100;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        done <= 0;
        out_byte <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in == 0) begin // start bit detected
                    state <= START_BIT;
                    bit_count <= 0;
                end
            end
            START_BIT: begin
                if (in == 0) begin // start bit is valid
                    state <= DATA_BITS;
                end
                else begin // start bit not valid, go back to IDLE
                    state <= IDLE;
                end
            end
            DATA_BITS: begin
                data_reg[bit_count] <= in; // shift in data bit
                bit_count <= bit_count + 1;
                if (bit_count == 4'd7) begin // all 8 data bits received
                    state <= STOP_BIT;
                end
            end
            STOP_BIT: begin
                if (in == 1) begin // stop bit is valid
                    out_byte <= data_reg;
                    done <= 1;
                    state <= IDLE;
                end
                else begin // stop bit not valid, wait for a valid stop bit
                    state <= WAIT_STOP;
                end
            end
            WAIT_STOP: begin
                if (in == 1) begin // valid stop bit found
                    state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

endmodule
