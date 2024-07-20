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

    reg [31:0] updated_history;

    always @(posedge clk or negedge areset) begin
        if (!areset) begin
            if (train_mispredicted) begin
                updated_history <= {train_history, train_taken};
            end else if (predict_valid) begin
                updated_history <= {predict_history[30:0], predict_taken};
            end
        end else begin
            updated_history <= 0;
        end
    end
    
    always @(posedge clk) begin
        predict_history <= updated_history;
    end
    
endmodule
