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

// 7-bit PC and global history
reg [6:0] pc_history;

// 128-entry table of 2-bit saturating counters
reg [1:0] pht [127:0];

// Hash PC and history to 7-bit index
function [6:0] hash(input [6:0] pc, input [6:0] history);
    hash = pc ^ history;
endfunction

// Prediction logic
always @(*) begin
    if (predict_valid) begin
        predict_taken = pht[hash(predict_pc, pc_history)][1];
        predict_history = pc_history;
    end else begin
        predict_taken = 1'b0;
        predict_history = 7'b0;
    end
end

// Training logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        pc_history <= 7'b0;
        for (int i = 0; i < 128; i++) begin
            pht[i] <= 2'b10;
        end
    end else begin
        if (train_valid) begin
            // Update PHT based on branch outcome
            if (train_taken) begin
                if (pht[hash(train_pc, train_history)][1]) begin
                    pht[hash(train_pc, train_history)] <= 2'b11;
                end else begin
                    pht[hash(train_pc, train_history)] <= 2'b10;
                end
            end else begin
                if (pht[hash(train_pc, train_history)]) begin
                    pht[hash(train_pc, train_history)] <= 2'b01;
                end else begin
                    pht[hash(train_pc, train_history)] <= 2'b00;
                end
            end

            // Update branch history register
            if (train_mispredicted) begin
                pc_history <= train_history;
            end else begin
                pc_history <= {pc_history[5:0], train_taken};
            end
        end
    end
end

endmodule
