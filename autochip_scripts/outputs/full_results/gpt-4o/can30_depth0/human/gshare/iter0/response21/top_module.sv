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

    // Branch history register
    reg [6:0] global_history;

    // Pattern history table: 128 entries of 2-bit saturating counters
    reg [1:0] PHT [0:127];

    // Function to hash PC and history
    function [6:0] hash_index;
        input [6:0] pc;
        input [6:0] history;
        begin
            hash_index = pc ^ history;
        end
    endfunction

    // Reset logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
        end else if (train_valid && train_mispredicted) begin
            global_history <= train_history;
        end else if (predict_valid) begin
            global_history <= {global_history[5:0], predict_taken};
        end
    end

    // Prediction logic
    always @(*) begin
        if (predict_valid) begin
            predict_history = global_history;
            predict_taken = PHT[hash_index(predict_pc, global_history)][1];
        end else begin
            predict_taken = 0;
            predict_history = 7'b0;
        end
    end

    // Training logic
    always @(posedge clk) begin
        if (train_valid) begin
            // Get the index for the current training
            reg [6:0] index = hash_index(train_pc, train_history);

            // Update the PHT entry
            if (train_taken) begin
                if (PHT[index] < 2'b11) begin
                    PHT[index] <= PHT[index] + 1;
                end
            end else begin
                if (PHT[index] > 2'b00) begin
                    PHT[index] <= PHT[index] - 1;
                end
            end
        end
    end

endmodule
