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
    
    logic [31:0] global_history_reg;
    reg [31:0] rollback_history_reg;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history_reg <= 32'b0;
            rollback_history_reg <= 32'b0;
        end else begin
            if (train_mispredicted) begin
                global_history_reg <= {train_history, train_taken};
                rollback_history_reg <= global_history_reg;
            end else begin
                if (predict_valid) begin
                    global_history_reg <= {global_history_reg[30:0], predict_taken};
                end
            end
        end
    end
    
    assign predict_history = rollback_history_reg;
    
endmodule
