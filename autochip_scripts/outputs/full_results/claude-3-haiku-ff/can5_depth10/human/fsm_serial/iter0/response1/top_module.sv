module top_module(
    input clk,
    input in,
    input reset,
    output reg done
);

localparam IDLE = 0;
localparam START_BIT = 1;
localparam DATA_BIT = 2;
localparam STOP_BIT = 3;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data <= 0;
        done <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in == 0) begin // Start bit detected
                    state <= START_BIT;
                    bit_count <= 0;
                    data <= 0;
                end
            end
            START_BIT: begin
                if (in == 0) begin // Wait for start bit
                    state <= DATA_BIT;
                end
                else begin
                    state <= IDLE; // Start bit not detected, go back to IDLE
                end
            end
            DATA_BIT: begin
                data[bit_count] <= in; // Capture data bit
                bit_count <= bit_count + 1;
                if (bit_count == 4'd7) begin // All 8 data bits received
                    state <= STOP_BIT;
                end
            end
            STOP_BIT: begin
                if (in == 1) begin // Stop bit detected
                    done <= 1;
                    state <= IDLE;
                end
                else begin
                    state <= IDLE; // Stop bit not detected, go back to IDLE
                end
            end
        endcase
    end
end

endmodule
