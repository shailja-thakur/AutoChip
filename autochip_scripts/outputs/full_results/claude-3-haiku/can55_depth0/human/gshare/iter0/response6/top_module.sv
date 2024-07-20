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
    reg [6:0] global_history;

    // 128-entry table of two-bit saturating counters
    reg [1:0] pht[127:0];

    // Hash function to get 7-bit index from PC and global history
    function [6:0] hash_index;
        input [6:0] pc;
        input [6:0] history;
        begin
            hash_index = pc ^ history;
        end
    endfunction

    // Prediction logic
    always @* begin
        if (predict_valid) begin
            // Hash PC and global history to get index into PHT
            integer index = hash_index(predict_pc, global_history);
            // Predict taken if counter value is 2 or 3 (taken)
            predict_taken = (pht[index] >= 2);
            // Output current global history
            predict_history = global_history;
        end else begin
            predict_taken = 1'b0;
            predict_history = 7'b0;
        end
    end

    // Training logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (integer i = 0; i < 128; i = i + 1) begin
                pht[i] <= 2'b10; // Initialize PHT to weakly taken
            end
        end else begin
            if (train_valid) begin
                // Hash PC and global history to get index into PHT
                integer index = hash_index(train_pc, train_history);
                // Update PHT based on actual branch outcome
                if (train_taken) begin
                    pht[index] <= (pht[index] == 2'b00) ? 2'b01 : (pht[index] == 2'b11) ? 2'b11 : pht[index] + 1;
                end else begin
                    pht[index] <= (pht[index] == 2'b11) ? 2'b10 : (pht[index] == 2'b00) ? 2'b00 : pht[index] - 1;
                end
                // Update global history register
                if (train_mispredicted) begin
                    global_history <= train_history;
                end else begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end
        end
    end

endmodule
