module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

// Define the states
localparam [2:0] IDLE = 3'd0;
localparam [2:0] START_BIT = 3'd1;
localparam [2:0] DATA_BITS = 3'd2;
localparam [2:0] STOP_BIT = 3'd3;
localparam [2:0] ERROR = 3'd4;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        done <= 0;
        out_byte <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 0) begin
                    state <= START_BIT;
                    bit_count <= 0;
                end
            end
            START_BIT: begin
                if (in == 0) begin
                    state <= DATA_BITS;
                end else begin
                    state <= ERROR;
                end
            end
            DATA_BITS: begin
                data_reg[bit_count] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 4'd7) begin
                    state <= STOP_BIT;
                end
            end
            STOP_BIT: begin
                if (in == 1) begin
                    out_byte <= data_reg;
                    done <= 1;
                    state <= IDLE;
                end else begin
                    state <= ERROR;
                end
            end
            ERROR: begin
                done <= 0;
                // Wait for a stop bit before attempting to receive the next byte
                if (in == 1) begin
                    state <= IDLE;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
