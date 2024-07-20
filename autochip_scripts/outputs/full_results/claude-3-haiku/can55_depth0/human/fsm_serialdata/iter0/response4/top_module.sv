module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

// States for the FSM
parameter IDLE = 3'd0;
parameter START = 3'd1;
parameter DATA = 3'd2;
parameter STOP = 3'd3;
parameter ERROR = 3'd4;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] shift_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        shift_reg <= 0;
        done <= 0;
    end else begin
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
                    bit_count <= 0;
                end else begin
                    bit_count <= bit_count + 1;
                end
            end
            DATA: begin
                shift_reg[bit_count] <= in;
                if (bit_count == 4'd7) begin
                    state <= STOP;
                    bit_count <= 0;
                end else begin
                    bit_count <= bit_count + 1;
                end
            end
            STOP: begin
                if (in == 1'b1) begin
                    out_byte <= shift_reg;
                    done <= 1'b1;
                    state <= IDLE;
                end else begin
                    state <= ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1) begin
                    state <= IDLE;
                    done <= 1'b0;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
