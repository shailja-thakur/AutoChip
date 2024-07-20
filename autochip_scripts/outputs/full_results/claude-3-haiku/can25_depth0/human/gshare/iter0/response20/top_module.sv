module top_module(
    input clk,
    input areset,

    input predict_valid,
    input [6:0] predict_pc,
    output predict_taken,
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);

    // 7-bit global branch history register
    reg [6:0] branch_history_reg;

    // 128-entry pattern history table (PHT) of 2-bit saturating counters
    reg [1:0] pht[127:0];

    // Hash function to get the index into the PHT
    function [6:0] hash_function;
        input [6:0] pc;
        input [6:0] history;
        begin
            hash_function = pc ^ history;
        end
    endfunction

    // Prediction logic
    always @(*) begin
        if (predict_valid) begin
            // Hash the PC and branch history to get the PHT index
            reg [6:0] index = hash_function(predict_pc, branch_history_reg);

            // Get the predicted branch direction from the PHT
            predict_taken = (pht[index] >= 2'b10);

            // Output the current branch history register value
            predict_history = branch_history_reg;
        end else begin
            predict_taken = 1'b0;
            predict_history = 7'b0;
        end
    end

    // Training logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            branch_history_reg <= 7'b0;
            for (int i = 0; i < 128; i++) begin
                pht[i] <= 2'b01;
            end
        end else begin
            if (train_valid) begin
                // Hash the training PC and history to get the PHT index
                reg [6:0] index = hash_function(train_pc, train_history);

                // Update the PHT entry based on the actual branch outcome
                if (train_taken) begin
                    if (pht[index] != 2'b11) begin
                        pht[index] <= pht[index] + 1'b1;
                    end
                end else begin
                    if (pht[index] != 2'b00) begin
                        pht[index] <= pht[index] - 1'b1;
                    end
                end

                // If the branch was mispredicted, update the branch history register
                if (train_mispredicted) begin
                    branch_history_reg <= train_history;
                end else begin
                    // Otherwise, update the branch history register with the predicted direction
                    branch_history_reg <= {branch_history_reg[5:0], train_taken};
                end
            end
        end
    end

endmodule
