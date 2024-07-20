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
                 STOP = 3'b011,
                 ERROR = 3'b100;

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
                if (in == 1'b0) begin // Start bit detected
                    next_state <= START;
                    bit_count <= 0;
                end
                else begin
                    next_state <= IDLE;
                end
                done <= 0;
            end
            START: begin
                if (in == 1'b0) begin // Still in start bit
                    next_state <= START;
                end
                else begin // Start bit ended, move to data bits
                    next_state <= DATA;
                end
            end
            DATA: begin
                data_reg[bit_count] <= in;
                if (bit_count == 4'b0111) begin // All 8 data bits received
                    next_state <= STOP;
                    bit_count <= 0;
                end
                else begin
                    next_state <= DATA;
                    bit_count <= bit_count + 1;
                end
            end
            STOP: begin
                if (in == 1'b1) begin // Stop bit received
                    next_state <= IDLE;
                    out_byte <= data_reg;
                    done <= 1;
                end
                else begin // Stop bit not received
                    next_state <= ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1) begin // Stop bit finally received
                    next_state <= IDLE;
                    done <= 0;
                end
                else begin
                    next_state <= ERROR;
                end
            end
            default: begin
                next_state <= IDLE;
            end
        endcase
    end
end

endmodule
