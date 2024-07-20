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

logic [31:0] history_buffer;
logic [0:31] temp_history;

always @(posedge clk or posedge areset) begin
    if (areset)
        predict_history <= 0;
    else if (train_mispredicted) begin
        temp_history = {train_history, train_taken};
        predict_history <= temp_history;
    end else if (predict_valid) begin
        history_buffer = predict_taken ? {history_buffer[30:0], 1} : {history_buffer[30:0], 0};
        predict_history <= history_buffer;
    end
end

endmodule
