module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] shift_reg;

localparam IDLE = 3'd0;
localparam START_BIT = 3'd1;
localparam DATA_BITS = 3'd2;
localparam STOP_BIT = 3'd3;
localparam ERROR = 3'd4;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        shift_reg <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 0) begin // start bit detected
                    state <= START_BIT;
                    bit_count <= 0;
                end
            end
            START_BIT: begin
                if (in == 0) begin // valid start bit
                    state <= DATA_BITS;
                end else begin // invalid start bit
                    state <= ERROR;
                end
            end
            DATA_BITS: begin
                shift_reg[bit_count] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 4'd7) begin // all data bits received
                    state <= STOP_BIT;
                end
            end
            STOP_BIT: begin
                if (in == 1) begin // valid stop bit
                    out_byte <= shift_reg;
                    done <= 1;
                    state <= IDLE;
                end else begin // invalid stop bit
                    state <= ERROR;
                end
            end
            ERROR: begin
                // wait for a valid stop bit
                if (in == 1) begin
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
