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

    reg [6:0] ghr;
    reg [6:0] pht_index;
    reg [1:0] pht_value;
    reg [1:0] pht_table [0:127];
    reg predict_req;
    reg train_req;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            ghr <= 7'b00;
            pht_index <= 7'b0000000;
            pht_value <= 2'b00;
            predict_taken <= 1'b0;
            predict_history <= 7'b0000000;
        end else begin
            if (train_req) begin
                pht_table[pht_index] <= pht_value;
                if (train_mispredicted) begin
                    pht_table[pht_index] <= pht_table[pht_index] - 1;
                    ghr <= train_history;
                end 
            end 
              if (predict_req) begin
                pht_value <= pht_table[pht_index];
                predict_taken <= (pht_value == 2'b11) ? 1'b1 : 1'b0;
                predict_history <= ghr;
              end 
          
          if(predict_valid && train_valid)
          begin
            predict_req<=1'b0;
            train_req<=1'b1;
            ghr <= train_history;
            pht_index <= train_pc ^ ghr;
            pht_value <= pht_table[pht_index];
          end else if(predict_valid)
          begin
            predict_req<=1'b1;
            train_req<=1'b0;
            pht_index <= predict_pc ^ ghr;
            pht_value <= pht_table[pht_index];
            if(pht_table[pht_index]<2'b11)
              predict_taken<=1'b0;
            else
              predict_taken<=1'b1;
          end else if(train_valid)
          begin
            predict_req<=1'b0;
            train_req<=1'b1;
            pht_index <= train_pc ^ ghr;
            if(train_mispredicted)
              ghr<=train_history;
            pht_table[pht_index] <= pht_value;
          end  
        end 
    end 

endmodule
