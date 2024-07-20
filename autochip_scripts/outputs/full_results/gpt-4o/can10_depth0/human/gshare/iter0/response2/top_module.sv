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

    // Define the global branch history register
    reg [6:0] global_history;

    // Define the pattern history table (PHT)
    reg [1:0] pht [127:0];

    // Asynchronous reset logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            predict_history <= 7'b0;
        end else if (predict_valid && !train_valid) begin
            // Compute the index for prediction
            predict_history <= global_history;
            predict_taken <= (pht[predict_pc ^ global_history] >= 2'b10);
            global_history <= {global_history[5:0], predict_taken};  // Update global history
        end
    end

    // Training logic
    always @(posedge clk) begin
        if (train_valid) begin
            // Compute the index for training
            integer index;
            index = train_pc ^ train_history;

            // Update the PHT based on the actual outcome
            if (train_taken) begin
                if (pht[index] < 2'b11)
                    pht[index] <= pht[index] + 1;
            end else begin
                if (pht[index] > 2'b00)
                    pht[index] <= pht[index] - 1;
            end

            // Handle misprediction recovery
            if (train_mispredicted) begin
                global_history <= {train_history[5:0], train_taken};
            end else if (!predict_valid) begin
                global_history <= {global_history[5:0], train_taken};
            end
        end
    end
    
endmodule
