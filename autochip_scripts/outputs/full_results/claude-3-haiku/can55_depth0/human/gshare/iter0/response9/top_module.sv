module top_module(
    input clk,
    input areset,

    input predict_valid,
    input [6:0] predict_pc,
    output reg predict_taken,
    output reg [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);

reg [1:0] pht[127:0]; // 128-entry pattern history table

always @(posedge clk or posedge areset) begin
    if (areset) begin
        predict_history <= 0;
        for (int i = 0; i < 128; i++) begin
            pht[i] <= 2'b10; // Initialize PHT to weakly not-taken
        end
    end
    else begin
        // Prediction logic
        if (predict_valid) begin
            // Hash predict_pc and predict_history to get PHT index
            wire [6:0] index = predict_pc ^ predict_history;
            // Make prediction based on PHT entry
            predict_taken <= (pht[index] >= 2'b10);
            // Update predict_history
            predict_history <= {predict_history[5:0], predict_taken};
        end

        // Training logic
        if (train_valid) begin
            // Hash train_pc and train_history to get PHT index
            wire [6:0] index = train_pc ^ train_history;
            // Update PHT entry based on actual branch outcome
            if (train_taken) begin
                if (pht[index] != 2'b11) begin
                    pht[index] <= pht[index] + 1'b1; // Increment if not already strongly taken
                end
            end
            else begin
                if (pht[index] != 2'b00) begin
                    pht[index] <= pht[index] - 1'b1; // Decrement if not already strongly not-taken
                end
            end
            // Update branch history register if mispredicted
            if (train_mispredicted) begin
                predict_history <= train_history;
            end
        end
    end
end

endmodule
