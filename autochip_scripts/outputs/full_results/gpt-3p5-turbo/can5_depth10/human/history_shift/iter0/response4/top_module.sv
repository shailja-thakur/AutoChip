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
    
    reg [31:0] history_counter;
    reg [31:0] temp_history;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            history_counter <= 0;
        end else begin
            if (predict_valid) begin
                history_counter <= {history_counter[30:0], predict_taken};
            end else if (train_mispredicted) begin
                temp_history <= {train_history, train_taken};
                history_counter <= temp_history;
            end
        end
    end
    
    assign predict_history = history_counter;
    
endmodule
