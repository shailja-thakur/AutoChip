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

    // Define internal signals and registers
    reg [31:0] history_register;
    reg [31:0] temp_history;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            history_register <= 0;
        end else begin
            if (train_mispredicted) begin
                temp_history <= {train_history, train_taken};
            end else begin
                temp_history <= predict_valid ? {predict_history[30:0], predict_taken} : predict_history;
            end
            if (train_mispredicted) begin
                history_register <= temp_history;
            end
            else if (predict_valid) begin
                history_register <= temp_history;
            end
        end
    end
    
    assign predict_history = history_register;
    
endmodule
