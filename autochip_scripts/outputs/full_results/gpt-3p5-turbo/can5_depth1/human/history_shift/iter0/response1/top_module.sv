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
    
    logic [31:0] shift_reg;
    reg [31:0] temp_predict_history;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            shift_reg <= 0;
            temp_predict_history <= 0;
        end else begin
            if (predict_valid) begin
                temp_predict_history[31:0] <= {temp_predict_history[30:0], predict_taken};
            end
            
            if (train_mispredicted) begin
                temp_predict_history[31:0] <= {train_history[30:0], train_taken};
            end
            
            shift_reg <= temp_predict_history;
        end
    end
    
    assign predict_history = shift_reg;
    
endmodule
