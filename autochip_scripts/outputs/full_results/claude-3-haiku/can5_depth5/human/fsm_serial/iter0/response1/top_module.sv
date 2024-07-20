module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

// Define the states for the finite state machine
localparam STATE_IDLE = 3'b000;
localparam STATE_START = 3'b001;
localparam STATE_DATA = 3'b010;
localparam STATE_STOP = 3'b011;
localparam STATE_ERROR = 3'b100;

// Declare internal registers
reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_IDLE;
        bit_count <= 0;
        data_reg <= 0;
        done <= 0;
    end
    else begin
        case (state)
            STATE_IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    state <= STATE_START;
                    bit_count <= 0;
                end
            end
            STATE_START: begin
                if (in == 1'b0) begin // Start bit still valid
                    state <= STATE_DATA;
                end
                else begin // Start bit invalid, go to error state
                    state <= STATE_ERROR;
                end
            end
            STATE_DATA: begin
                data_reg[bit_count] <= in; // Shift in data bit
                bit_count <= bit_count + 1;
                if (bit_count == 4'd7) begin // All 8 data bits received
                    state <= STATE_STOP;
                end
            end
            STATE_STOP: begin
                if (in == 1'b1) begin // Stop bit is valid
                    state <= STATE_IDLE;
                    done <= 1'b1;
                end
                else begin // Stop bit is invalid, go to error state
                    state <= STATE_ERROR;
                end
            end
            STATE_ERROR: begin
                if (in == 1'b1) begin // Wait for stop bit
                    state <= STATE_IDLE;
                end
            end
            default: begin
                state <= STATE_IDLE;
            end
        endcase
    end
end

endmodule
