module top_module (
    input clk,
    input enable,
    input S,
    input A,
    input B,
    input C,
    output reg [7:0] q,
    output reg Z
);

reg [7:0] q_temp;
reg [2:0] address;
reg [2:0] mux_out;

always @(posedge clk) begin
    if (enable) begin
        q_temp <= {S, q_temp[7:1]};
    end
end

always @* begin
    case ({A, B, C})
        3'b000: address = 3'b000;
        3'b001: address = 3'b001;
        3'b010: address = 3'b010;
        3'b011: address = 3'b011;
        3'b100: address = 3'b100;
        3'b101: address = 3'b101;
        3'b110: address = 3'b110;
        3'b111: address = 3'b111;
    endcase
end

always @(address, q_temp) begin
    case (address)
        3'b000: mux_out = q_temp[0];
        3'b001: mux_out = q_temp[1];
        3'b010: mux_out = q_temp[2];
        3'b011: mux_out = q_temp[3];
        3'b100: mux_out = q_temp[4];
        3'b101: mux_out = q_temp[5];
        3'b110: mux_out = q_temp[6];
        3'b111: mux_out = q_temp[7];
    endcase
end

assign q = q_temp;
assign Z = mux_out;

endmodule
