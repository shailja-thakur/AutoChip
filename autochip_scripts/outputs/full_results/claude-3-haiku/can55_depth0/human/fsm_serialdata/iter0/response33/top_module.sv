module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

parameter IDLE = 3'd0;
parameter START = 3'd1;
parameter DATA = 3'd2;
parameter STOP = 3'd3;
parameter ERROR = 3'd4;

reg [2:0] state;
reg [2:0] bit_count;
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
                if (in == 1'b0) // start bit detected
                    state <= START;
                else
                    state <= IDLE;
                bit_count <= 0;
                data_reg <= 0;
                done <= 0;
            end
            START: begin
                if (in == 1'b0) // valid start bit
                    state <= DATA;
                else // invalid start bit
                    state <= ERROR;
                bit_count <= 0;
            end
            DATA: begin
                data_reg[bit_count] <= in; // shift in data bit
                if (bit_count == 3'd7) // all 8 data bits received
                    state <= STOP;
                else
                    bit_count <= bit_count + 1;
            end
            STOP: begin
                if (in == 1'b1) // valid stop bit
                begin
                    out_byte <= data_reg;
                    done <= 1'b1;
                    state <= IDLE;
                end
                else // invalid stop bit
                    state <= ERROR;
            end
            ERROR: begin
                // wait for stop bit
                if (in == 1'b1)
                    state <= IDLE;
                else
                    state <= ERROR;
                done <= 0;
            end
        endcase
    end
end

endmodule
