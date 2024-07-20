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

    logic [31:0] global_history;

    always @(posedge clk or posedge areset) begin
        if (areset)
            global_history <= 0;
        else begin
            if (train_mispredicted) begin
                global_history <= {train_history, train_taken};
            end else if (predict_valid) begin
                global_history <= {predict_history[30:0], predict_taken};
            end
        end
    end

    assign predict_history = global_history;

endmodule
