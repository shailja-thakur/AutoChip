module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting);

   reg [3:0] state;
   wire [3:0] next_state;
   wire sequence_found;
   
   assign next_state = state;
   assign sequence_found = (state == 4'b1101);
   
   always @(posedge clk) begin
      if (reset) begin
         state <= 4'b0000;
      end else begin
         state <= next_state;
      end
   end
   
   always @(posedge clk) begin
      if (reset) begin
         start_shifting <= 1'b0;
      end else begin
         start_shifting <= (sequence_found && ~start_shifting);
      end
   end

endmodule
