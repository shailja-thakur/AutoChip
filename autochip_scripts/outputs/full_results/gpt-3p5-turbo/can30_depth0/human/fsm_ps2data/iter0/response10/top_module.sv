module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [1:0] state;
reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;
reg [23:0] out_bytes_reg;
wire done_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= 2'b00;
        byte1 <= 8'b0;
        byte2 <= 8'b0;
        byte3 <= 8'b0;
        out_bytes_reg <= 24'b0;
    end else begin
        case (state)
            2'b00:
                if (in[3]) begin
                    byte1 <= in;
                    state <= 2'b01;
                end
            2'b01:
                begin
                    byte2 <= in;
                    state <= 2'b10;
                end
            2'b10:
                begin
                    byte3 <= in;
                    state <= 2'b11;
                end
            2'b11:
                begin
                    state <= 2'b00;
                end
        endcase
    end
end

assign out_bytes = out_bytes_reg;
assign done = done_reg;

always @(state, byte1, byte2, byte3) begin
    if (state == 2'b11) begin
        out_bytes_reg = {byte1, byte2, byte3};
        done_reg = 1'b1;
    end else begin
        out_bytes_reg = 24'b0;
        done_reg = 1'b0;
    end
end

endmodule
