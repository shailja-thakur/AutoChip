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

    reg [31:0] shift_reg;
    reg [31:0] new_history;
    
    always @(posedge clk or posedge areset)
    begin
        if (areset)
            shift_reg <= 0;
        else if (train_mispredicted)
            shift_reg <= new_history;
        else if (predict_valid)
            shift_reg <= {shift_reg[30:0], predict_taken};
    end
    
    always @(posedge clk or posedge areset)
    begin
        if (areset)
            predict_history <= 0;
        else if (train_mispredicted)
            predict_history <= {new_history[30:0], predict_taken};
        else if (predict_valid)
            predict_history <= {shift_reg[30:0], predict_taken};
        else
            predict_history <= shift_reg;
    end
    
    always @(posedge clk or posedge areset)
    begin
        if (areset)
            new_history <= 0;
        else if (train_mispredicted)
            new_history <= {train_history[30:0], train_taken};
        else if (predict_valid)
            new_history <= {shift_reg[30:0], predict_taken};
        else
            new_history <= shift_reg[30:0];
    end
    
endmodule
