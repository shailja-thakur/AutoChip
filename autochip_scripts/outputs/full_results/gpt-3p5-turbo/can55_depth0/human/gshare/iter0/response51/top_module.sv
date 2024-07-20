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

    reg [6:0] branch_history_reg;
    reg [2:0] pht [0:127];
    reg [1:0] predict_result;
    
    reg [2:0] prediction; 
    reg [2:0] train_result;
    
    always@(posedge clk or negedge areset)
    begin
        if (areset == 0)
        begin
            branch_history_reg <= 7'b0;
            pht <= 128'b0;
        end
        else
        begin
            if (train_valid == 1)
            begin
                if (train_mispredicted == 1)
                begin
                    branch_history_reg <= train_history;
                    pht[train_pc] <= 2'b00;
                end
                else
                begin
                    if (predict_valid == 1 && predict_pc == train_pc)
                        branch_history_reg <= train_history;
                    pht[train_pc] <= train_result;
                end
            end
            else if (predict_valid == 1)
            begin
                if (predict_pc == train_pc)
                    branch_history_reg <= predict_history;
                prediction <= pht[predict_pc];
            end
        end
    end
    
    always@(posedge clk or negedge areset)
    begin
        if (areset == 0)
        begin
            predict_taken <= 1'b0;
            predict_history <= 7'b0;
        end
        else if (predict_valid == 1)
        begin
            predict_taken <= (predict_result > 1);
            predict_history <= branch_history_reg;
        end
    end
    
    always@(posedge clk or negedge areset)
    begin
        if (areset == 0)
            train_result <= 2'b0;
        else if (train_valid == 1)
            train_result <= train_taken ? (train_result < 3'b11 ? train_result + 1 : 3'b11) : (train_result > 0 ? train_result - 1 : 2'b0);
    end
    
    assign predict_result = prediction;
endmodule
