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
    
    reg [6:0] GHR; // Global Branch History Register
    reg [6:0] PHT_index1;
    wire [1:0] prediction1;
    reg [6:0] PHT_index2;
    wire [1:0] prediction2;
    reg [6:0] PHT_index;
    wire [1:0] prediction;
    
    reg [1:0] PHT_table [0:127];
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            GHR <= 0;
        else if (predict_valid) begin
            PHT_index1 <= predict_pc ^ GHR;
            predict_history <= GHR;
            prediction1 <= PHT_table[PHT_index1];
        end else if (train_valid && !train_mispredicted) begin
            PHT_index2 <= train_pc ^ train_history;
            prediction2 <= PHT_table[PHT_index2];
        end else if (train_valid && train_mispredicted) begin
            PHT_index <= train_pc ^ train_history;
            PHT_table[PHT_index] <= train_taken;
            GHR <= train_history;
            predict_history <= GHR;
            prediction <= PHT_table[PHT_index];
        end
    end
    
    assign predict_taken = (predict_valid) ? prediction1[1] : prediction2[1];
    
endmodule
