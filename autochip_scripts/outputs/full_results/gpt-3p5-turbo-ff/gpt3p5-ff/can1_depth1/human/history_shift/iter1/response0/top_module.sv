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
    wire [31:0] updated_history;

    always @(posedge clk or posedge areset) begin
        if (areset)
            shift_reg <= 0;
        else if (predict_valid)
            shift_reg <= {shift_reg[30:0], predict_taken};
        else if (train_mispredicted)
            shift_reg <= {train_history[30:0], train_taken};
    end

    assign updated_history = (train_mispredicted) ? {train_history[0:30], train_taken} : shift_reg;
    assign predict_history = (predict_valid & train_mispredicted) ? updated_history : shift_reg;

endmodule
