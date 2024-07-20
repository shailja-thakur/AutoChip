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
    reg [6:0] global_history;
    reg [127:0] pattern_history_table [0:127];
    reg [1:0] branch_prediction_table [0:127];
    
    always @(posedge clk or posedge areset) begin
        if(areset) begin
            global_history <= 0;
            pattern_history_table <= 0;
            branch_prediction_table <= 0;
        end else begin
            if(predict_valid) begin
                predict_taken <= branch_prediction_table[predict_pc];
                predict_history <= global_history;
            end
            if(train_valid) begin
                branch_prediction_table[train_pc] <= branch_prediction_table[train_pc] + (train_taken ? 1 : -1);
                global_history <= {global_history[5:0], train_taken};
                if(train_mispredicted) begin
                    global_history <= train_history;
                    pattern_history_table[train_pc] <= pattern_history_table[train_pc] - (train_taken ? 1 : -1);
                end
            end
        end
    end
endmodule
