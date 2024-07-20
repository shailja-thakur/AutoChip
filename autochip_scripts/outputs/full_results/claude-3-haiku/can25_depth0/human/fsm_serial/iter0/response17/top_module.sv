module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam IDLE = 3'b000; // Waiting for start bit
localparam START = 3'b001; // Received start bit, receiving data
localparam DATA = 3'b010; // Receiving data bits
localparam STOP = 3'b011; // Checking for stop bit
localparam ERROR = 3'b100; // Stop bit not received correctly

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
                if (in == 1'b0) // Start bit detected
                    state <= START;
                else
                    state <= IDLE;
                bit_count <= 0;
                data_reg <= 0;
                done <= 0;
            end
            START: begin
                state <= DATA;
                bit_count <= 1;
            end
            DATA: begin
                data_reg[bit_count-1] <= in; // Shift in data bit
                if (bit_count == 4'd8) // All 8 data bits received
                    state <= STOP;
                else
                    bit_count <= bit_count + 1;
            end
            STOP: begin
                if (in == 1'b1) // Stop bit received correctly
                    state <= IDLE;
                    done <= 1;
                else // Stop bit not received correctly
                    state <= ERROR;
                bit_count <= 0;
            end
            ERROR: begin
                if (in == 1'b1) // Wait for stop bit
                    state <= IDLE;
                else
                    state <= ERROR;
            end
            default:
                state <= IDLE;
        endcase
    end
end

endmodule
