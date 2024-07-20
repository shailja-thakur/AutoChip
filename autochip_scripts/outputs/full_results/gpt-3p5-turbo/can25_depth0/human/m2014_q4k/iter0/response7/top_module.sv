module top_module (
   input clk,
   input resetn,
   input in,
   output out
);

reg [3:0] shift_reg;
wire [3:0] next_shift_reg;

always @(posedge clk or negedge resetn) begin
   if (!resetn) begin
      shift_reg <= 4'b0;
   end else begin
      shift_reg <= next_shift_reg;
   end
end

assign out = shift_reg[0];

always @* begin
   next_shift_reg[0] = in;
   next_shift_reg[1] = shift_reg[0];
   next_shift_reg[2] = shift_reg[1];
   next_shift_reg[3] = shift_reg[2];
end

endmodule
