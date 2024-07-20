module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam [2:0] IDLE = 3'b000, START = 3'b001, DATA = 3'b010, STOP = 3'b011, ERROR = 3'b100;
reg [2:0] state, next_state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        done <= 0;
        bit_count <= 0;
        data_reg <= 0;
    end
    else begin
        state <= next_state;

        case (state)
            IDLE: begin
                if (in == 1'b0) begin // start bit detected
                    next_state <= START;
                    bit_count <= 0;
                end
                else begin
                    next_state <= IDLE;
                end
            end

            START: begin
                if (in == 1'b0) begin // start bit is valid
                    next_state <= DATA;
                end
                else begin // start bit is invalid
                    next_state <= IDLE;
                end
            end

            DATA: begin
                data_reg[bit_count] <= in; // read data bit
                bit_count <= bit_count + 1;
                if (bit_count == 4'd7) begin // all 8 data bits received
                    next_state <= STOP;
                end
                else begin
                    next_state <= DATA;
                end
            end

            STOP: begin
                if (in == 1'b1) begin // stop bit is valid
                    done <= 1'b1;
                    next_state <= IDLE;
                end
                else begin // stop bit is invalid
                    next_state <= ERROR;
                end
            end

            ERROR: begin
                if (in == 1'b1) begin // wait for stop bit
                    next_state <= IDLE;
                    done <= 1'b0;
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
