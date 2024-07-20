module top_module(
   input clk,
   input resetn,
   input [1:0] byteena,
   input [15:0] d,
   output reg [15:0] q
);

reg [15:0] q_reg;

always @(posedge clk or negedge resetn) begin
   if (!resetn) begin
      q_reg <= 16'b0;
   end else begin
      q_reg <= byteena[1] ? {q[15:8], d[7:0]} : {q[15:8], q[7:0]};
   end
end

assign q = byteena[0] ? {d[7:0], q[7:0]} : {q[7:0], d[7:0]};

endmodule
