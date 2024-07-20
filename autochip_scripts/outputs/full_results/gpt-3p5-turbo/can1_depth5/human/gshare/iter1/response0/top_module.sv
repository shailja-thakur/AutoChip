module top_module(
    input clk,
    input areset,
    
    input predict_valid,
    input [6:0] predict_pc,
    output reg predict_taken,
    output reg [6:0] predict_history,
    
    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);
    
    reg [2:0] pht[0:127];
    reg [6:0] bhr;
    
    reg [6:0] predict_index;
    reg [2:0] predict_state;
    
    reg [6:0] train_index;
    reg [2:0] train_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            pht <= 0;
            bhr <= 0;
        end else if (train_valid) begin
            train_index <= train_pc ^ bhr;
            train_state <= pht[train_index];
            
            pht[train_index] <= (train_mispredicted) ? 
                ((train_state == 0) ? 0 : train_state - 1) :
                ((train_state == 3) ? 3 : train_state + 1);
            
            bhr <= {bhr[5:0], train_taken};
        end else if (predict_valid) begin
            predict_index <= predict_pc ^ bhr;
            predict_state <= pht[predict_index];
            
            bhr <= {bhr[5:0], predict_taken};
        end
    end
    
    always @* begin
        predict_taken = (predict_valid && (predict_state >= 2)) ? 1'b1 : 1'b0;
        predict_history = bhr;
    end
    
endmodule
