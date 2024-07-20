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

    reg [31:0] history_shift_register;
    reg [31:0] temp_predict_history;
    reg [31:0] temp_train_history;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            history_shift_register <= 0;
        end else begin
            if (train_mispredicted) begin
                temp_train_history <= {train_history[30:0], train_taken};
            end
            if (predict_valid) begin
                temp_predict_history <= {predict_history[30:0], predict_taken};
            end
            if (train_mispredicted) begin
                history_shift_register <= temp_train_history;
            end else if (predict_valid) begin
                history_shift_register <= temp_predict_history;
            end
        end
    end

    assign predict_history = history_shift_register;

endmodule
