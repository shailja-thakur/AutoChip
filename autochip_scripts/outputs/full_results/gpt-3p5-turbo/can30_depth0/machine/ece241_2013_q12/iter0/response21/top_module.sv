module top_module (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output reg Z
);

reg [7:0] q;
reg [2:0] addr;
wire [7:0] shifted_q;

always @(posedge clk) begin
    if (enable) begin
        q <= {S, q[7:1]};
    end
end

always @(A, B, C) begin
    case ({A, B, C})
        3'b000: addr = 3'b000;
        3'b001: addr = 3'b001;
        3'b010: addr = 3'b010;
        3'b011: addr = 3'b011;
        3'b100: addr = 3'b100;
        3'b101: addr = 3'b101;
        3'b110: addr = 3'b110;
        3'b111: addr = 3'b111;
        default: addr = 3'b000;
    endcase
end

assign shifted_q = {q[addr], q[7:addr+1]};
assign Z = shifted_q[0];

endmodule
