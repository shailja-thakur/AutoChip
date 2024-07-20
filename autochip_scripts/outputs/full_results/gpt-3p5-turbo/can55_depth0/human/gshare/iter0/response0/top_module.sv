module top_module(
    input clk,
    input areset,

    input predict_valid,
    input [6:0] predict_pc,
    output predict_taken,
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);

reg [1:0] PHT [0:127];
reg [6:0] GHR;
reg [6:0] train_pc_reg;
reg [6:0] predict_pc_reg;
reg predict_valid_reg;

always @(posedge clk or posedge areset) begin
   if (areset)
       GHR <= 0;
   else begin
       if (train_valid) begin
           PHT[train_pc[6:0]] <= (train_mispredicted) ? $unsigned(PHT[train_pc[6:0]]) - 1'b1 : $unsigned(PHT[train_pc[6:0]]) + 1'b1;
        GHR <= {GHR[5:0], train_taken};
       end
   else begin
       predict_history <= GHR;
       predict_taken <= PHT[predict_pc[6:0]] > 1'b1;
       GHR <= {GHR[5:0], predict_taken};
       if (predict_valid_reg)
           PHT[predict_pc_reg[6:0]] <= (predict_taken) ? $unsigned(PHT[predict_pc_reg[6:0]]) + 1'b1 : $unsigned(PHT[predict_pc_reg[6:0]]) - 1'b1;
      predict_pc_reg <= predict_pc;
      predict_valid_reg <= predict_valid;
      
      end
   end
end

always @(posedge clk or posedge areset) begin
   if (areset)
       train_pc_reg <= 0;
   else 
       train_pc_reg <= train_pc;
end

endmodule
