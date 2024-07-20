module top_module
(
    input wire clk,
    input wire areset,
    input wire predict_valid,
    input wire predict_taken,
    output logic [31:0] predict_history,
    
    input wire train_mispredicted,
    input wire train_taken,
    input wire [31:0] train_history
);

    always_ff @(posedge clk or negedge areset)
    begin
        if (areset == 0)
            predict_history <= 0;
        else if (train_mispredicted)
            predict_history <= {train_history, train_taken};
        else if (predict_valid)
            predict_history <= predict_taken;
    end

endmodule
