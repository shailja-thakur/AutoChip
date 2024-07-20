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

    // 7-bit global history register
    reg [6:0] global_history;

    // 128-entry PHT of 2-bit saturating counters
    reg [1:0] pht[127:0];

    // Hash function to generate PHT index
    function [6:0] hash_index(input [6:0] pc, input [6:0] history);
        hash_index = pc ^ history;
    endfunction

    // Update global history register
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
        end
        else if (train_valid) begin
            if (train_mispredicted) begin
                global_history <= train_history;
            end
            else begin
                global_history <= {global_history[5:0], train_taken};
            end
        end
    end

    // Prediction logic
    always @* begin
        if (predict_valid) begin
            predict_history = global_history;
            predict_taken = pht[hash_index(predict_pc, global_history)][1];
        end
        else begin
            predict_history = 7'b0;
            predict_taken = 1'b0;
        end
    end

    // Training logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            for (int i = 0; i < 128; i++) begin
                pht[i] <= 2'b01;
            end
        end
        else if (train_valid) begin
            if (train_mispredicted) begin
                pht[hash_index(train_pc, train_history)] <= (train_taken) ? 2'b10 : 2'b01;
            end
            else begin
                pht[hash_index(train_pc, train_history)] <= (train_taken) ? 2'b11 : 2'b00;
            end
        end
    end

endmodule
