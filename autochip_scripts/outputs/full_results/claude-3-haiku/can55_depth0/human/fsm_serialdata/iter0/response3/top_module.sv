module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam IDLE = 3'd0;
localparam START = 3'd1;
localparam DATA = 3'd2;
localparam STOP = 3'd3;
localparam ERROR = 3'd4;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] shift_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        shift_reg <= 0;
        out_byte <= 0;
        done <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    state <= START;
                    bit_count <= 0;
                end
            end
            START: begin
                if (bit_count == 4'd1) begin
                    state <= DATA;
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
            DATA: begin
                shift_reg <= {in, shift_reg[7:1]};
                if (bit_count == 4'd9) begin
                    state <= STOP;
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
            STOP: begin
                if (in == 1'b1) begin
                    out_byte <= shift_reg;
                    done <= 1'b1;
                    state <= IDLE;
                end
                else begin
                    state <= ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1) begin
                    state <= IDLE;
                    done <= 1'b0;
                end
            end
            default: state <= IDLE;
        endcase
    end
end

endmodule
