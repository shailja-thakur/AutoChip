module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam IDLE = 3'b000;
localparam START_BIT = 3'b001;
localparam DATA_BITS = 3'b010;
localparam STOP_BIT = 3'b011;
localparam ERROR = 3'b100;

reg [2:0] state;
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
                if (in == 0) begin // Start bit detected
                    state <= START_BIT;
                    bit_count <= 0;
                end
            end
            START_BIT: begin
                if (in == 1) begin // Start bit is valid
                    state <= DATA_BITS;
                end else begin // Start bit is invalid
                    state <= ERROR;
                end
            end
            DATA_BITS: begin
                data_reg[bit_count] <= in; // Shift in data bit
                bit_count <= bit_count + 1;
                if (bit_count == 7) begin // All 8 data bits received
                    state <= STOP_BIT;
                end
            end
            STOP_BIT: begin
                if (in == 1) begin // Stop bit is valid
                    done <= 1;
                    state <= IDLE;
                end else begin // Stop bit is invalid
                    state <= ERROR;
                end
            end
            ERROR: begin
                // Stay in ERROR state until a valid stop bit is found
                if (in == 1) begin
                    state <= IDLE;
                    bit_count <= 0;
                    data_reg <= 0;
                    done <= 0;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
