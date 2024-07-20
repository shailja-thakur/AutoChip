module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam [1:0] IDLE = 2'b00, 
                 START = 2'b01,
                 DATA = 2'b10,
                 STOP = 2'b11;

reg [1:0] state, next_state;
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
                    data_reg <= 0;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            START: begin
                if (bit_count == 4'd0) begin
                    if (in == 1'b0) begin // Valid start bit
                        next_state <= DATA;
                        bit_count <= 1;
                    end
                    else begin // Invalid start bit
                        next_state <= IDLE;
                        bit_count <= 0;
                    end
                end
                else begin
                    next_state <= START;
                    bit_count <= bit_count + 1;
                end
            end
            DATA: begin
                if (bit_count < 4'd9) begin
                    data_reg[bit_count - 1] <= in; // Shift in data bits
                    next_state <= DATA;
                    bit_count <= bit_count + 1;
                end
                else begin
                    next_state <= STOP;
                    bit_count <= 0;
                end
            end
            STOP: begin
                if (in == 1'b1) begin // Valid stop bit
                    next_state <= IDLE;
                    done <= 1'b1;
                end
                else begin // Invalid stop bit
                    next_state <= IDLE;
                    done <= 1'b0;
                end
            end
            default: begin
                next_state <= IDLE;
                bit_count <= 0;
                data_reg <= 0;
                done <= 1'b0;
            end
        endcase
    end
end

endmodule
