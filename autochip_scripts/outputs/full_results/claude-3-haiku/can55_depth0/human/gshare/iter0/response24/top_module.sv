module top_module (
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

    // 7-bit PC and 7-bit global history, hashed using XOR
    wire [6:0] hash_index = predict_pc ^ predict_history;

    // 128-entry table of 2-bit saturating counters
    reg [1:0] pht [127:0];

    initial begin
        for (integer i = 0; i < 128; i = i + 1) begin
            pht[i] = 2'b10;
        end
    end

    // Update the branch history register on prediction
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_history <= 7'b0;
        end
        else if (predict_valid) begin
            predict_history <= {predict_history[5:0], predict_taken};
        end
    end

    // Make prediction based on PHT counter value
    always @* begin
        if (predict_valid) begin
            predict_taken = (pht[hash_index] >= 2'b10);
        end
        else begin
            predict_taken = 1'b0;
        end
    end

    // Train the branch predictor
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            for (integer i = 0; i < 128; i = i + 1) begin
                pht[i] <= 2'b10;
            end
            predict_history <= 7'b0;
        end
        else begin
            if (train_valid) begin
                // Update PHT
                if (train_taken) begin
                    if (pht[train_pc ^ train_history] != 2'b11)
                        pht[train_pc ^ train_history] <= pht[train_pc ^ train_history] + 1'b1;
                end
                else begin
                    if (pht[train_pc ^ train_history] != 2'b00)
                        pht[train_pc ^ train_history] <= pht[train_pc ^ train_history] - 1'b1;
                end

                // Update branch history register
                if (train_mispredicted) begin
                    predict_history <= train_history;
                end
            end
        end
    end

endmodule
