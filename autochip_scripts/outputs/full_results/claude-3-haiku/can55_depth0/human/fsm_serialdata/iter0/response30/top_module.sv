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
reg [2:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        out_byte <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 0) begin
                    state <= START;
                    bit_count <= 1;
                end
            end
            START: begin
                if (in == 0) begin
                    state <= DATA;
                    bit_count <= 0;
                end else begin
                    state <= ERROR;
                end
            end
            DATA: begin
                data_reg <= {in, data_reg[7:1]};
                bit_count <= bit_count + 1;
                if (bit_count == 7) begin
                    state <= STOP;
                end
            end
            STOP: begin
                if (in == 1) begin
                    state <= IDLE;
                    out_byte <= data_reg;
                    done <= 1;
                end else begin
                    state <= ERROR;
                end
                bit_count <= 0;
            end
            ERROR: begin
                if (in == 1) begin
                    state <= IDLE;
                end
                bit_count <= 0;
                done <= 0;
            end
        endcase
    end
end

endmodule
