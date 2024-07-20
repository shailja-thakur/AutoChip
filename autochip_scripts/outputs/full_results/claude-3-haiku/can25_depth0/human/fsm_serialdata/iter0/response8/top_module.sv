module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam IDLE     = 3'b000;
localparam START_BIT = 3'b001;
localparam DATA     = 3'b010;
localparam STOP_BIT = 3'b011;

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
                if (in == 0) begin // Start bit detected
                    state <= START_BIT;
                    bit_count <= 0;
                end
            end
            START_BIT: begin
                if (in == 1) begin // Check if start bit is valid
                    state <= DATA;
                end
                else begin
                    state <= IDLE; // Start bit not valid, go back to IDLE
                end
            end
            DATA: begin
                data_reg[bit_count] <= in; // Shift in data bit
                bit_count <= bit_count + 1;
                if (bit_count == 7) begin
                    state <= STOP_BIT; // All 8 data bits received
                end
            end
            STOP_BIT: begin
                if (in == 1) begin // Check if stop bit is valid
                    out_byte <= data_reg; // Output the received data
                    done <= 1;
                    state <= IDLE; // Go back to IDLE
                end
                else begin
                    state <= IDLE; // Stop bit not valid, go back to IDLE
                end
                done <= 0; // Reset done signal
            end
        endcase
    end
end

endmodule
