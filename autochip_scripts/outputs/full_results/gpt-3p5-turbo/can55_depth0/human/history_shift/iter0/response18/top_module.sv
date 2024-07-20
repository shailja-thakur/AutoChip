module top_module
(
    input clk,
    input areset,
    input predict_valid,
    input predict_taken,
    output reg [31:0] predict_history,
    
    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);

reg [31:0] history_buffer;

always @(posedge clk or posedge areset) begin
    if (areset)
        history_buffer <= 0;
    else if (train_mispredicted)
        history_buffer <= {train_history, train_taken};
    else if (predict_valid)
        history_buffer <= {predict_history[30:0], predict_taken};
end

assign predict_history = history_buffer;

endmodule
