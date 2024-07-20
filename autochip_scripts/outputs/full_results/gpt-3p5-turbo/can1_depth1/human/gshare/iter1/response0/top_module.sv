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

reg [6:0] branch_history;
reg [6:0] index;
reg [1:0] pht [0:127];

always @(posedge clk or posedge areset) begin
    if (areset) begin
        branch_history <= 0;
        predict_taken <= 0;
        predict_history <= 0;
    end else if (predict_valid) begin
        branch_history <= {branch_history[5:0], predict_taken};
    end else if (train_valid) begin
        branch_history <= {branch_history[5:0], train_taken};
        index <= {predict_pc[6:0], branch_history[6:0]} ^ {predict_pc[0], branch_history[0]};
        if (train_mispredicted) begin
            pht[index] <= pht[index] - 1;
        end else begin
            pht[index] <= pht[index] + 1;
        end
    end
end

always @(predict_valid or areset) begin
    if (areset) begin
        predict_taken <= 0;
    end else begin
        index <= {predict_pc[6:0], branch_history[6:0]} ^ {predict_pc[0], branch_history[0]};
        predict_taken <= (pht[index] > 1);
    end
end

assign predict_history = branch_history;

endmodule
