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
    // Define a 128-entry table of 2-bit saturating counters
    reg [1:0] PHT [0:127];
    integer i;

    // Global history register
    reg [6:0] global_history;

    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset the global history register and PHT entries
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Initialize counters to weakly taken
            end
        end else begin
            if (train_valid) begin
                // Calculate the index for the PHT using the train_pc and train_history
                reg [6:0] train_index;
                train_index = train_pc ^ train_history;
                
                // Update the PHT based on the training outcome
                if (train_taken) begin
                    if (PHT[train_index] < 2'b11) begin
                        PHT[train_index] <= PHT[train_index] + 1;
                    end
                end else begin
                    if (PHT[train_index] > 2'b00) begin
                        PHT[train_index] <= PHT[train_index] - 1;
                    end
                end
                
                // Update the global history register
                if (train_mispredicted) begin
                    global_history <= {global_history[5:0], train_taken};
                end else begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end else if (predict_valid) begin
                // Calculate the index for the PHT using the predict_pc and global_history
                reg [6:0] predict_index;
                predict_index = predict_pc ^ global_history;

                // Provide the prediction based on the current PHT state
                predict_taken = (PHT[predict_index] >= 2'b10);

                // Update the global history register
                global_history <= {global_history[5:0], predict_taken};

                // Output the current history used for prediction
                predict_history <= global_history;
            end
        end
    end
endmodule
