module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

parameter BYTE1 = 0;
parameter BYTE2 = 1;
parameter BYTE3 = 2;
parameter DONE = 3;

reg [1:0] state;
reg [23:0] shift_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= BYTE1;
        shift_reg <= 0;
    end else begin
        case(state)
            BYTE1:begin
                if(in[2] == 1)begin
                    state <= BYTE2;
                end else begin
                    state <= BYTE1;
                end
                shift_reg <= (shift_reg << 8) | in;
            end
            BYTE2:begin
                if(in[2] == 1)begin
                    state <= BYTE3;
                end else begin
                    state <= BYTE1;
                end
                shift_reg <= (shift_reg << 8) | in;
            end
            BYTE3:begin
                if(in[2] == 1)begin
                    state <= DONE;
                end else begin
                    state <= BYTE1;
                end
                shift_reg <= (shift_reg << 8) | in;
            end
            DONE:begin
                state <= BYTE1;
                shift_reg <= (shift_reg << 8) | in;
            end
            default:begin
                state <= BYTE1;
                shift_reg <= (shift_reg << 8) | in;
            end
        endcase
    end
end

assign out_bytes = (done == 1) ? shift_reg : 0;
assign done = (state == DONE) ? 1 : 0;

endmodule
