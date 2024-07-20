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

    reg [31:0] global_history;
    reg reset_history;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 0;
            reset_history <= 1;
        end
        else if (reset_history) begin
            global_history <= 0;
            reset_history <= 0;
        end
        else if (predict_valid)
            global_history <= {global_history[30:0], predict_taken};
        else if (train_mispredicted)
            global_history <= {train_history, train_taken};
    end
    
    assign predict_history = global_history;

endmodule
