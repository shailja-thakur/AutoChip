module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

localparam IDLE = 3'b000;
localparam START = 3'b001;
localparam DATA = 3'b010;
localparam STOP = 3'b011;
localparam WAIT_STOP = 3'b100;

always @(posedge clk) begin
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
                    data_reg <= 0;
                end
            end
            START: begin
                if (bit_count == 3'd1) begin // Wait for start bit to complete
                    state <= DATA;
                    bit_count <= 0;
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
            DATA: begin
                data_reg <= {in, data_reg[7:1]}; // Shift in data bit
                if (bit_count == 3'd8) begin // 8 data bits received
                    state <= STOP;
                    bit_count <= 0;
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
            STOP: begin
                if (in == 1'b1) begin // Stop bit detected
                    done <= 1'b1;
                    state <= IDLE;
                end
                else begin // No stop bit, wait for it
                    state <= WAIT_STOP;
                end
            end
            WAIT_STOP: begin
                if (in == 1'b1) begin // Stop bit detected
                    done <= 1'b1;
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
