module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

localparam IDLE = 3'd0;
localparam START_BIT = 3'd1;
localparam DATA_BITS = 3'd2;
localparam STOP_BIT = 3'd3;
localparam WAIT_STOP = 3'd4;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        done <= 0;
        out_byte <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) // start bit detected
                    state <= START_BIT;
                else
                    state <= IDLE;
            end
            START_BIT: begin
                if (in == 1'b0) // start bit is valid
                    state <= DATA_BITS;
                else // start bit is invalid
                    state <= IDLE;
            end
            DATA_BITS: begin
                data_reg[bit_count] <= in; // sample data bit
                bit_count <= bit_count + 1;
                if (bit_count == 4'd7) // all 8 data bits received
                    state <= STOP_BIT;
                else
                    state <= DATA_BITS;
            end
            STOP_BIT: begin
                if (in == 1'b1) begin // stop bit is valid
                    out_byte <= data_reg;
                    done <= 1'b1;
                    state <= IDLE;
                    bit_count <= 0;
                end
                else // stop bit is invalid
                    state <= WAIT_STOP;
            end
            WAIT_STOP: begin
                if (in == 1'b1) // valid stop bit found
                    state <= IDLE;
                else
                    state <= WAIT_STOP;
            end
        endcase
    end
end

endmodule
