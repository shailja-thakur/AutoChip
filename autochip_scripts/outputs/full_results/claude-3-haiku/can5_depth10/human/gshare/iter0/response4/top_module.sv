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
reg [6:0] global_history;

// 128-entry 2-bit saturating counter PHT
reg [1:0] pht [127:0];

// Hash PC and global history to get PHT index
function [6:0] hash_index;
    input [6:0] pc;
    input [6:0] history;
    begin
        hash_index = pc ^ history;
    end
endfunction

// Update global history register
always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 'b0;
    end
    else if (train_valid) begin
        if (train_mispredicted) begin
            global_history <= train_history;
        end
        else begin
            global_history <= {global_history[5:0], train_taken};
        end
    end
    else if (predict_valid) begin
        global_history <= {global_history[5:0], predict_taken};
    end
end

// Prediction logic
always @* begin
    if (predict_valid) begin
        predict_taken = pht[hash_index(predict_pc, global_history)][1];
        predict_history = global_history;
    end
    else begin
        predict_taken = 1'b0;
        predict_history = 'b0;
    end
end

// Training logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        for (integer i = 0; i < 128; i = i + 1) begin
            pht[i] <= 2'b10;
        end
    end
    else if (train_valid) begin
        // Update PHT
        if (train_mispredicted) begin
            pht[hash_index(train_pc, train_history)] <= (train_taken) ? 2'b11 : 2'b00;
        end
        else begin
            case (pht[hash_index(train_pc, train_history)])
                2'b00: pht[hash_index(train_pc, train_history)] <= (train_taken) ? 2'b01 : 2'b00;
                2'b01: pht[hash_index(train_pc, train_history)] <= (train_taken) ? 2'b11 : 2'b00;
                2'b10: pht[hash_index(train_pc, train_history)] <= (train_taken) ? 2'b11 : 2'b01;
                2'b11: pht[hash_index(train_pc, train_history)] <= (train_taken) ? 2'b11 : 2'b10;
            endcase
        end
    end
end

endmodule
