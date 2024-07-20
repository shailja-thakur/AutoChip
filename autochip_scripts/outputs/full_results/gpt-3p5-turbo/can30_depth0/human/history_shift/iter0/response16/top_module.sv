module top_module
(
    input clk,
    input areset,
    input predict_valid,
    input predict_taken,
    output logic [31:0] predict_history,
    
    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);

    // Pipeline registers
    logic [31:0] branch_history;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            branch_history <= 0;
        else if (train_mispredicted)
            branch_history <= {train_history[30:0], train_taken};
        else if (predict_valid)
            branch_history <= {branch_history[30:0], predict_taken};
    end

    assign predict_history = branch_history;

endmodule
