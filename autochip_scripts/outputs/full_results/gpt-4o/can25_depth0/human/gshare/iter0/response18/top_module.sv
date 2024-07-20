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

    // Branch History Register (BHR)
    reg [6:0] global_history;

    // Pattern History Table (PHT) with 128 entries with 2-bit saturating counters
    reg [1:0] PHT [127:0];

    // Indices
    wire [6:0] predict_index;
    wire [6:0] train_index;

    // Predicting
    assign predict_index = predict_pc ^ global_history;
    
    // Extract BHR and PHT index for prediction
    assign predict_history = global_history;
    assign predict_taken = PHT[predict_index][1]; // Predict taken if the MSB of the counter is 1

    // Training
    assign train_index = train_pc ^ train_history;

    // Update BHR and PHT in the next clock cycle
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'd0;
            integer i;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Initialize to weakly not taken
            end
        end
        else begin
            // Training takes precedence over prediction
            if (train_valid) begin
                // Update the global history register based on the outcome of the branch being trained
                if (train_mispredicted) begin
                    global_history <= {train_history[5:0], train_taken};
                end
                else begin
                    global_history <= {global_history[5:0], train_taken};
                end

                // Update the PHT entry
                if (train_taken) begin
                    if (PHT[train_index] < 2'b11)
                        PHT[train_index] <= PHT[train_index] + 1;
                end
                else begin
                    if (PHT[train_index] > 2'b00)
                        PHT[train_index] <= PHT[train_index] - 1;
                end
            end
            else if (predict_valid) begin
                // Update the global history register for the predicted branch
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

endmodule
