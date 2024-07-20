module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam IDLE = 3'b000;
localparam START = 3'b001;
localparam DATA = 3'b010;
localparam STOP = 3'b011;
localparam ERROR = 3'b100;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 0) begin // Start bit detected
                    state <= START;
                    bit_count <= 0;
                    data_reg <= 0;
                end
            end
            START: begin
                if (in == 1) begin // Valid start bit
                    state <= DATA;
                end else begin
                    state <= ERROR; // Invalid start bit
                end
            end
            DATA: begin
                data_reg[bit_count] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 4'd7) begin
                    state <= STOP;
                end
            end
            STOP: begin
                if (in == 1) begin // Valid stop bit
                    out_byte <= data_reg;
                    done <= 1;
                    state <= IDLE;
                end else begin
                    state <= ERROR; // Invalid stop bit
                end
                bit_count <= 0;
            end
            ERROR: begin
                if (in == 1) begin // Wait for next start bit
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
