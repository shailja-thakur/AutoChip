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

    // Intermediate signal to store the next state of predict_history
    logic [31:0] next_predict_history;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_history <= 32'd0;
        end
        else begin
            predict_history <= next_predict_history;
        end
    end

    always_comb begin
        next_predict_history = predict_history;

        if (train_mispredicted) begin
            next_predict_history = train_history;
            if (train_taken) begin
                next_predict_history[0] = 1'b1; // Assuming LSB for recent branch taken
            end
        end
        else if (predict_valid) begin
            next_predict_history = {predict_history[30:0], predict_taken}; // Update history with predict_taken
        end
    end

endmodule
