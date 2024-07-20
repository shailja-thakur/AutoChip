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

reg predict_taken;
reg [6:0] predict_history;
reg [6:0] branch_history_register;

reg [6:0] index;
reg [1:0] table [0:127];

always @(posedge clk or posedge areset) begin
    if (areset) begin
        branch_history_register <= 0;
    end else if (predict_valid) begin
        index <= (predict_pc ^ branch_history_register) % 128;
        predict_taken <= table[index][1];
        predict_history <= branch_history_register;
    end else if (train_valid) begin
        index <= (train_pc ^ train_history) % 128;
        if (train_mispredicted) begin
            table[index][1] <= table[index][1] + 1;
        end
        if (train_taken) begin
            table[index][1] <= table[index][1] + 1;
        end
        branch_history_register <= {branch_history_register[5:0], train_taken};
    end
end

endmodule
