module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam [2:0] IDLE = 3'b000, START = 3'b001, DATA = 3'b010, STOP = 3'b011, ERROR = 3'b100;
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
        case (state)
            IDLE: begin
                if (in == 0) begin // Start bit detected
                    next_state <= START;
                    bit_count <= 0;
                    data_reg <= 0;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            START: begin
                if (bit_count == 0 && in == 0) begin // Verify start bit
                    next_state <= DATA;
                    bit_count <= 1;
                end
                else begin
                    next_state <= ERROR;
                    bit_count <= 0;
                end
            end
            DATA: begin
                data_reg[bit_count-1] <= in; // Shift in data bit
                if (bit_count == 8) begin
                    next_state <= STOP;
                    bit_count <= 0;
                end
                else begin
                    next_state <= DATA;
                    bit_count <= bit_count + 1;
                end
            end
            STOP: begin
                if (in == 1) begin // Verify stop bit
                    out_byte <= data_reg;
                    done <= 1;
                    next_state <= IDLE;
                end
                else begin
                    next_state <= ERROR;
                    done <= 0;
                end
            end
            ERROR: begin
                if (in == 1) begin // Wait for stop bit
                    next_state <= IDLE;
                    done <= 0;
                end
                else begin
                    next_state <= ERROR;
                    done <= 0;
                end
            end
            default: begin
                next_state <= IDLE;
                bit_count <= 0;
                data_reg <= 0;
                out_byte <= 0;
                done <= 0;
            end
        endcase
    end
end

endmodule
