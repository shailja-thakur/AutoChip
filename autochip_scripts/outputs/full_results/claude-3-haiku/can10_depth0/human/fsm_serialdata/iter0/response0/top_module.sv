module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam IDLE = 3'b000;
localparam START_BIT = 3'b001;
localparam DATA_BITS = 3'b010;
localparam STOP_BIT = 3'b011;
localparam ERROR = 3'b100;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_register;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_register <= 0;
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
                data_register[bit_count] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 4'd7) begin
                    state <= STOP_BIT;
                end
            end
            STOP_BIT: begin
                if (in == 1) begin
                    out_byte <= data_register;
                    done <= 1;
                    state <= IDLE;
                end else begin
                    state <= ERROR;
                end
            end
            ERROR: begin
                // Wait for a valid stop bit
                if (in == 1) begin
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
