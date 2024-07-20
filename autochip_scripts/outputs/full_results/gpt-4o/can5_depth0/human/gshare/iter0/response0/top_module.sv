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

    // 128-entry table of 2-bit saturating counters
    reg [1:0] PHT[0:127]; 
    integer i;
    reg [6:0] global_branch_history;

    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_branch_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1)
                PHT[i] <= 2'b01; // Initialize to weakly taken
        end else begin
            // Train the predictor on the next positive clock edge
            if (train_valid) begin
                // Compute index
                integer index = train_pc ^ train_history;
                
                // Train the PHT based on actual branch outcome
                if (train_taken) begin
                    if (PHT[index] < 2'b11)
                        PHT[index] <= PHT[index] + 1;
                end else begin
                    if (PHT[index] > 2'b00)
                        PHT[index] <= PHT[index] - 1;
                end

                // Update global branch history
                if (train_mispredicted) begin
                    global_branch_history <= train_history;
                end else begin
                    global_branch_history <= {global_branch_history[5:0], train_taken};
                end
            end else if (predict_valid) begin
                // Update history register after a prediction
                global_branch_history <= {global_branch_history[5:0], predict_taken};
            end
        end
    end

    // Prediction logic
    always @(*) begin
        predict_history = global_branch_history;
        if (predict_valid) begin
            // Compute index
            integer index = predict_pc ^ global_branch_history;
            // Make prediction
            predict_taken = PHT[index] >= 2'b10;
        end else begin
            predict_taken = 0;
        end
    end

endmodule
