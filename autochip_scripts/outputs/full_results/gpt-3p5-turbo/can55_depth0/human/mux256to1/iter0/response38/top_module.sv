module top_module (
  input [255:0] in,
  input [7:0] sel,
  output  out
);

reg [7:0] next_sel;
reg [1:0] sel_index;
wire [7:0] selected_input;

always @* begin
    case(sel)
        8'b00000000: sel_index = 2'b00;
        8'b00000001: sel_index = 2'b01;
        default: sel_index = 2'b10;
    endcase
end

always @(posedge clk) begin
    next_sel <= sel;
end

assign selected_input = in[(sel_index*8)+7 : (sel_index*8)];
assign out = selected_input;

endmodule
