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

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            shift_reg <= 32'b0;
        end else begin
            if (train_mispredicted == 1) begin
                shift_reg <= {train_history, train_taken};
            end else if (predict_valid == 1) begin
                shift_reg <= {shift_reg[30:0], predict_taken};
            end
        end
    end

    assign predict_history = shift_reg;

endmodule
