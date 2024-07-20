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

reg [1:0] pht[127:0]; // 128-entry 2-bit saturating counter table
reg [6:0] global_history;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 'b0;
        for (int i = 0; i < 128; i++) begin
            pht[i] <= 2'b10; // Initialize PHT to weakly taken
        end
    end
    else begin
        // Prediction logic
        if (predict_valid) begin
            // Hash the PC and global history to get the PHT index
            int index = predict_pc ^ global_history;
            predict_taken <= (pht[index[6:0]] >= 2'b10);
            predict_history <= global_history;
            // Update global history register
            global_history <= {global_history[5:0], predict_taken};
        end

        // Training logic
        if (train_valid) begin
            // Hash the PC and global history to get the PHT index
            int index = train_pc ^ train_history;
            // Update PHT entry
            if (train_mispredicted) begin
                // Adjust PHT entry in the direction of the actual branch outcome
                if (train_taken) begin
                    pht[index[6:0]] <= (pht[index[6:0]] == 2'b00) ? 2'b00 : pht[index[6:0]] - 1'b1;
                end
                else begin
                    pht[index[6:0]] <= (pht[index[6:0]] == 2'b11) ? 2'b11 : pht[index[6:0]] + 1'b1;
                end
                // Recover the global history register to the state immediately after the mispredicting branch
                global_history <= train_history;
            end
            else begin
                // Adjust PHT entry in the direction of the actual branch outcome
                if (train_taken) begin
                    pht[index[6:0]] <= (pht[index[6:0]] == 2'b11) ? 2'b11 : pht[index[6:0]] + 1'b1;
                end
                else begin
                    pht[index[6:0]] <= (pht[index[6:0]] == 2'b00) ? 2'b00 : pht[index[6:0]] - 1'b1;
                end
                // Update the global history register
                global_history <= {global_history[5:0], train_taken};
            end
        end
    end
end

endmodule
