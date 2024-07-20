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
    reg [31:0] shift_register;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            shift_register <= 0;
        end else if (predict_valid) begin
            shift_register <= {shift_register[30:0], predict_taken};
        end else if (train_mispredicted) begin
            shift_register <= {train_history, train_taken};
        end
    end
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_history <= 0;
        end else if (predict_valid || train_mispredicted) begin
            predict_history <= shift_register;
        end
    end
endmodule
