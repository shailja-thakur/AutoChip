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
    
    reg [1:0] PHT [0:127]; // Pattern History Table with 2-bit saturating counters
    reg [6:0] global_history; // 7-bit Global History Register
    
    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            integer i;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Initialize to weakly not-taken
            end
        end else begin
            if (train_valid) begin
                // Compute the index using XOR of train_pc and train_history
                int train_index = train_pc ^ train_history;
                
                // Update the PHT based on the actual branch outcome
                if (train_taken) begin
                    if (PHT[train_index] < 2'b11)
                        PHT[train_index] <= PHT[train_index] + 1;
                end else begin
                    if (PHT[train_index] > 2'b00)
                        PHT[train_index] <= PHT[train_index] - 1;
                end
                
                if (train_mispredicted) begin
                    global_history <= train_history;
                end else begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end else if (predict_valid) begin
                // Compute the index using XOR of predict_pc and global_history
                int predict_index = predict_pc ^ global_history;
                
                // Generate the prediction based on the PHT value
                predict_taken <= (PHT[predict_index] >= 2'b10);
                predict_history <= global_history;
                
                // Update global history register for the predicted branch
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end
    
endmodule
