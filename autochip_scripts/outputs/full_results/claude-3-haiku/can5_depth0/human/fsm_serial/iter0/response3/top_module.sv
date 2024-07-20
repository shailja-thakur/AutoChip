module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

// States
parameter IDLE = 0;
parameter START = 1;
parameter DATA = 2;
parameter STOP = 3;

// Counters
reg [2:0] bit_count;
reg [7:0] data_reg;

// State registers
reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        done <= 0;
        bit_count <= 0;
        data_reg <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in == 0) begin // Start bit detected
                    state <= START;
                    bit_count <= 0;
                end
                done <= 0;
            end
            START: begin
                if (bit_count == 3'd7) begin // 8 data bits received
                    state <= DATA;
                    bit_count <= 0;
                end
                else begin
                    bit_count <= bit_count + 1;
                    data_reg <= {data_reg[6:0], in};
                end
            end
            DATA: begin
                if (bit_count == 3'd7) begin // Stop bit expected
                    if (in == 1) begin
                        state <= STOP;
                        bit_count <= 0;
                    end
                    else begin
                        state <= IDLE; // Stop bit not received, wait for next start bit
                    end
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
            STOP: begin
                if (bit_count == 3'd0) begin
                    done <= 1; // Byte received correctly
                    state <= IDLE;
                end
                else begin
                    bit_count <= bit_count - 1;
                end
            end
        endcase
    end
end

endmodule
