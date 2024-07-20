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

localparam PHT_SIZE = 128;
reg [1:0] pht[PHT_SIZE-1:0];
reg [6:0] global_history;

always @(*) begin
    // Compute the PHT index from the PC and global history
    // using XOR hashing
    Integer pht_index = predict_pc ^ global_history;
    
    // Predict the branch direction based on the PHT entry
    predict_taken = (pht[pht_index] >= 2'b10);
    
    // Output the current global history
    predict_history = global_history;
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 7'b0;
        for (Integer i = 0; i < PHT_SIZE; i++) begin
            pht[i] <= 2'b01;
        end
    end
    else begin
        // Update the global history register
        if (predict_valid) begin
            global_history <= {global_history[5:0], predict_taken};
        end
        
        // Train the branch predictor
        if (train_valid) begin
            // Update the PHT entry
            Integer pht_index = train_pc ^ train_history;
            if (train_taken) begin
                pht[pht_index] <= (pht[pht_index] == 2'b11) ? 2'b11 : pht[pht_index] + 1'b1;
            end
            else begin
                pht[pht_index] <= (pht[pht_index] == 2'b00) ? 2'b00 : pht[pht_index] - 1'b1;
            end
            
            // Update the global history register if the branch was mispredicted
            if (train_mispredicted) begin
                global_history <= train_history;
            end
        end
    end
end

endmodule
