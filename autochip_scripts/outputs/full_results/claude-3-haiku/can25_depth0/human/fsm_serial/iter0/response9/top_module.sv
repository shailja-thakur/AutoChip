module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

// Define the states of the FSM
localparam [1:0] IDLE = 2'b00, START = 2'b01, DATA = 2'b10, STOP = 2'b11;

// Internal registers
reg [1:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk or posedge reset) begin
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
                if (bit_count == 4'd9) begin // 9 bit times have elapsed
                    state <= DATA;
                    bit_count <= 0;
                end
                else begin
                    bit_count <= bit_count + 1;
                    state <= START;
                end
            end
            DATA: begin
                if (bit_count == 4'd8) begin // 8 data bits have been received
                    state <= STOP;
                    bit_count <= 0;
                end
                else begin
                    data_reg <= {data_reg[6:0], in}; // Shift in the data bits
                    bit_count <= bit_count + 1;
                    state <= DATA;
                end
            end
            STOP: begin
                if (in == 1'b1) begin // Stop bit detected
                    state <= IDLE;
                    done <= 1'b1; // Signal that a byte has been received
                end
                else begin
                    state <= STOP;
                end
            end
            default:
                state <= IDLE;
        endcase
    end
end

endmodule
