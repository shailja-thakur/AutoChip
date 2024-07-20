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

    reg [1:0] pht [0:127]; // 128-entry table of two-bit saturating counters
    reg [6:0] global_history; // 7-bit global branch history register

    // Compute index using XOR of PC and global history
    wire [6:0] predict_index = predict_pc ^ global_history;
    wire [6:0] train_index = train_pc ^ train_history;

    // Asynchronous reset
    integer i;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                pht[i] <= 2'b01; // Initialize to weakly not taken
            end
        end else begin
            // Update global history register on predict
            if (predict_valid && !(train_valid && train_mispredicted)) begin
                global_history <= {global_history[5:0], predict_taken};
            end

            // Train the branch predictor
            if (train_valid) begin
                // Update the PHT for the train entry
                if (train_taken) begin
                    if (pht[train_index] != 2'b11) begin
                        pht[train_index] <= pht[train_index] + 1;
                    end
                end else begin
                    if (pht[train_index] != 2'b00) begin
                        pht[train_index] <= pht[train_index] - 1;
                    end
                end

                // Recover global_history if misprediction
                if (train_mispredicted) begin
                    global_history <= {train_history[5:0], train_taken};
                end
            end
        end
    end

    // Make a prediction
    always @(*) begin
        predict_history = global_history;
        predict_taken = (pht[predict_index] >= 2'b10); // Predict taken if counter is 2'b10 or 2'b11
    end

endmodule
