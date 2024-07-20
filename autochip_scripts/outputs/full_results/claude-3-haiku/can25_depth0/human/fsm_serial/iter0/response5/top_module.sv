module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

// Define the states of the finite state machine
localparam [2:0] IDLE = 3'b000,
                 START = 3'b001,
                 DATA = 3'b010,
                 STOP = 3'b011,
                 ERROR = 3'b100;

// Internal registers
reg [2:0] state;
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
        case (state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    state <= START;
                    bit_count <= 0;
                end
            end
            START: begin
                if (bit_count == 4'd9) begin // 1 start bit + 8 data bits
                    if (in == 1'b1) begin // Stop bit detected
                        state <= STOP;
                    end
                    else begin
                        state <= ERROR;
                    end
                end
                else begin
                    data_reg[bit_count] <= in; // Shift in data bits
                    bit_count <= bit_count + 1;
                end
            end
            STOP: begin
                if (in == 1'b1) begin // Valid stop bit
                    state <= IDLE;
                    done <= 1'b1;
                end
                else begin
                    state <= ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1) begin // Wait for stop bit
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
