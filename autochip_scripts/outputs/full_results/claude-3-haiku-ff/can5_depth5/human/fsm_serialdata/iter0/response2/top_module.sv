module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

// Define the states of the FSM
localparam IDLE       = 3'b000;
localparam START_BIT  = 3'b001;
localparam DATA_BITS  = 3'b010;
localparam STOP_BIT   = 3'b011;
localparam ERROR      = 3'b100;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

// FSM state transitions
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        done <= 0;
        out_byte <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (~in) begin // Start bit detected
                    state <= START_BIT;
                    bit_count <= 0;
                end
            end
            START_BIT: begin
                if (in) begin // Start bit is valid
                    state <= DATA_BITS;
                end else begin
                    state <= ERROR; // Start bit not valid
                end
            end
            DATA_BITS: begin
                data_reg[bit_count] <= in; // Shift in data bits
                bit_count <= bit_count + 1;
                if (bit_count == 4'd7) begin // All 8 data bits received
                    state <= STOP_BIT;
                end
            end
            STOP_BIT: begin
                if (in) begin // Stop bit is valid
                    out_byte <= data_reg;
                    done <= 1;
                    state <= IDLE;
                end else begin
                    state <= ERROR; // Stop bit not valid
                end
            end
            ERROR: begin
                if (in) begin // Wait for stop bit
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
