module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

// Define the states of the FSM
localparam [1:0] IDLE = 2'b00,
                 START = 2'b01,
                 DATA = 2'b10,
                 STOP = 2'b11;

reg [1:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    state <= START;
                    bit_count <= 0;
                end
            end
            START: begin
                if (bit_count == 4'd9) begin // 9 bits received (start + 8 data)
                    if (in == 1'b1) begin // Stop bit detected
                        state <= DATA;
                        bit_count <= 0;
                    end else begin
                        state <= IDLE; // Stop bit not detected, wait for next start bit
                    end
                end else begin
                    if (bit_count < 4'd8) begin // Shifting in data bits
                        data_reg <= {data_reg[6:0], in};
                    end
                    bit_count <= bit_count + 1;
                end
            end
            DATA: begin
                if (in == 1'b0) begin // Error, stop bit not detected
                    state <= IDLE;
                end else begin
                    state <= STOP;
                    done <= 1'b1; // Byte received successfully
                end
            end
            STOP: begin
                if (in == 1'b0) begin // Error, stop bit not detected
                    state <= IDLE;
                end else begin
                    state <= IDLE;
                    done <= 1'b0; // Reset done signal
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
