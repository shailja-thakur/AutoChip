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
    reg [1:0] PHT[127:0];
    
    // 7-bit global branch history register
    reg [6:0] global_history;
    
    // Reset and update logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            integer i;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Weakly taken (01) as initial state
            end
            global_history <= 7'b0;
        end else begin
            // Update the global history register based on prediction
            if (predict_valid && !train_valid) begin
                global_history <= {global_history[5:0], predict_taken};
            end else if (train_valid) begin
                if (train_mispredicted) begin
                    global_history <= {train_history[5:0], train_taken};
                end else begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end

            // Training the PHT
            if (train_valid) begin
                wire [6:0] train_index = train_pc ^ train_history;
                if (train_taken) begin
                    if (PHT[train_index] < 2'b11)
                        PHT[train_index] <= PHT[train_index] + 1;
                end else begin
                    if (PHT[train_index] > 2'b00)
                        PHT[train_index] <= PHT[train_index] - 1;
                end
            end
        end
    end

    // Prediction logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_taken <= 0;
            predict_history <= 7'b0;
        end else begin
            if (predict_valid) begin
                wire [6:0] predict_index = predict_pc ^ global_history;
                predict_taken <= PHT[predict_index] > 2'b01;
                predict_history <= global_history; // Update history to reflect current state
            end
        end
    end

endmodule
