module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam [2:0] IDLE = 3'd0,
                 START = 3'd1,
                 DATA = 3'd2,
                 STOP = 3'd3,
                 ERROR = 3'd4;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        out_byte <= 0;
        done <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    state <= START;
                    bit_count <= 0;
                    data_reg <= 0;
                end
            end
            START: begin
                if (in == 1'b0) begin // Valid start bit
                    state <= DATA;
                end
                else begin // Invalid start bit, wait for next start bit
                    state <= IDLE;
                end
            end
            DATA: begin
                data_reg[bit_count] <= in; // Shift in data bit
                bit_count <= bit_count + 1;
                if (bit_count == 4'd7) begin // All 8 data bits received
                    state <= STOP;
                end
            end
            STOP: begin
                if (in == 1'b1) begin // Valid stop bit
                    out_byte <= data_reg;
                    done <= 1'b1;
                    state <= IDLE;
                end
                else begin // Invalid stop bit, wait for next start bit
                    state <= IDLE;
                end
                bit_count <= 0;
                done <= 1'b0;
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
