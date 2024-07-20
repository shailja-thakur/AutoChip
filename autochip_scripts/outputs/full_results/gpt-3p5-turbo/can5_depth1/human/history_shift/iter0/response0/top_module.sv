module top_module
(
    input clk,
    input areset,
    input predict_valid,
    input predict_taken,
    output wire [31:0] predict_history,
    
    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);

reg [31:0] shift_register = 32'b0;
reg [31:0] train_history_temp;
reg [31:0] train_branch_result;

always @(posedge clk or posedge areset) begin
    if(areset)
        shift_register <= 0;
    else begin
        if(train_mispredicted) begin
            train_history_temp <= train_history;
            train_branch_result <= train_taken;
        end
        else begin
            train_history_temp <= {shift_register[30:0], predict_taken};
            train_branch_result <= 0;
        end
        if(predict_valid)
            shift_register <= {shift_register[30:0], predict_taken};
    end
end

always @(posedge clk or posedge areset) begin
    if(areset)
        predict_history <= 0;
    else begin
        if(train_mispredicted)
            predict_history <= {train_history_temp, train_branch_result};
        else
            predict_history <= shift_register;
    end
end

endmodule
