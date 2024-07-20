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
    
    reg [31:0] history_register;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            history_register <= 0;
        end else begin
            if (train_mispredicted) begin
                history_register <= {train_history, train_taken};
            end else if (predict_valid) begin
                history_register <= {history_register[30:0], predict_taken};
            end
        end
    end
    
    assign predict_history = history_register;
    
endmodule
