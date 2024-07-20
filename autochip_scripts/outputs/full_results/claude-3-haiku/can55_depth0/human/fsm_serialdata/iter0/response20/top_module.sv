module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam STATE_IDLE = 3'b000;
localparam STATE_START = 3'b001;
localparam STATE_DATA = 3'b010;
localparam STATE_STOP = 3'b011;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_IDLE;
        bit_count <= 0;
        data_reg <= 0;
        done <= 0;
    end else begin
        case (state)
            STATE_IDLE: begin
                if (in == 0) begin // Start bit detected
                    state <= STATE_START;
                    bit_count <= 0;
                end
            end
            STATE_START: begin
                if (in == 0) begin // Valid start bit
                    state <= STATE_DATA;
                end else begin // Invalid start bit
                    state <= STATE_IDLE;
                end
            end
            STATE_DATA: begin
                data_reg[bit_count] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 4'b1000) begin // All 8 data bits received
                    state <= STATE_STOP;
                end
            end
            STATE_STOP: begin
                if (in == 1) begin // Valid stop bit
                    out_byte <= data_reg;
                    done <= 1;
                    state <= STATE_IDLE;
                end else begin // Invalid stop bit
                    state <= STATE_IDLE;
                end
                done <= 0;
            end
        endcase
    end
end

endmodule
