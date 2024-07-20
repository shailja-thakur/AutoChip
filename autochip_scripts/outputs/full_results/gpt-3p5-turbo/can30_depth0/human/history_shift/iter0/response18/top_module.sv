module top_module
(
   input clk,
   input areset,
   input predict_valid,
   input predict_taken,
   output logic [31:0] predict_history,
   
   input train_mispredicted,
   input train_taken,
   input [31:0]  train_history
);

   // Shift register to store the branch history
   reg [31:0] history;

   always_ff @(posedge clk or posedge areset)
   begin
      if (areset)
         history <= 0;
      else if (train_mispredicted)
         history <= {train_history, train_taken};
      else if (predict_valid)
         history <= {history[30:0], predict_taken};
   end
   
   assign predict_history = history;

endmodule
