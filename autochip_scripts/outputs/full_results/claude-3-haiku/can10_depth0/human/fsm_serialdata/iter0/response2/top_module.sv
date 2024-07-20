module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam [2:0] IDLE = 3'b000,
                 START = 3'b001,
                 DATA = 3'b010,
                 STOP = 3'b011;

reg [2:0] state;
reg [2:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        done <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    state <= START;
                    bit_count <= 0;
                end
            end
            START: begin
                if (bit_count == 3'd3) begin // Wait for 3 cycles to sample start bit
                    if (in == 1'b0) begin
                        state <= DATA;
                    end
                    else begin
                        state <= IDLE; // Start bit not valid, go back to idle
                    end
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
            DATA: begin
                data_reg[bit_count] <= in; // Shift in data bits
                if (bit_count == 3'd7) begin
                    state <= STOP;
                    bit_count <= 0;
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
            STOP: begin
                if (in == 1'b1) begin // Stop bit detected
                    state <= IDLE;
                    out_byte <= data_reg;
                    done <= 1'b1;
                end
                else begin
                    state <= IDLE; // Stop bit not valid, go back to idle
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
