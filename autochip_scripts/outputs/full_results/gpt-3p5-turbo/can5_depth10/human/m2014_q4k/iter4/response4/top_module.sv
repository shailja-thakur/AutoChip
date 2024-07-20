module top_module (
     input clk,
     input resetn,
     input in,
     output out
);

reg [3:0] data_reg;
reg [3:0] data_next;
reg out_reg;

always @(posedge clk or negedge resetn) begin
     if (~resetn)
         data_reg <= 4'b0;
     else
         data_reg <= data_next;
end

always @(posedge clk or negedge resetn) begin
     if (~resetn)
         out_reg <= 1'b0;
     else if (data_reg[3])
         out_reg <= 1'b1;
     else
         out_reg <= 1'b0;
end

always @(posedge clk) begin
     if (resetn)
         data_next <= in;
     else
         data_next <= {data_reg[2:0], in};
end

assign out = out_reg;

endmodule
