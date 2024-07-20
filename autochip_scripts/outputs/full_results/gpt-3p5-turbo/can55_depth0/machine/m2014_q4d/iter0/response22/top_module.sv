module top_module (
    input clk,
    input in,
    output logic out
);

   logic reg_out;

   always_ff @(posedge clk)
   begin
       reg_out <= in ^ reg_out;
   end

   assign out = reg_out;

endmodule
