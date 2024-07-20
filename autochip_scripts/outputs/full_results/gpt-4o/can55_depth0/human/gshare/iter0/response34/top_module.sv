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
    
    reg [1:0] PHT [0:127]; // 128-entry table of 2-bit saturating counters
    reg [6:0] global_history; // 7-bit global branch history register
    
    // Initialize the PHT and global history register on reset
    integer i;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Weakly not taken
            end
        end else if (train_valid) begin
            // Update the PHT according to the actual branch outcome
            integer index = train_pc ^ train_history;
            if (train_taken) begin
                if (PHT[index] < 2'b11) PHT[index] <= PHT[index] + 1;
            end else begin
                if (PHT[index] > 2'b00) PHT[index] <= PHT[index] - 1;
            end

            // Update global history: training takes precedence if mispredicted
            if (train_mispredicted) begin
                global_history <= {train_history[5:0], train_taken};
            end else begin
                global_history <= {global_history[5:0], train_taken};
            end
        end
        // Update the global history register for prediction at the clock edge
        else if (predict_valid) begin
            global_history <= {global_history[5:0], predict_taken};
        end
    end

    // Prediction logic based on current global history and pc
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_taken <= 0;
            predict_history <= 7'b0;
        end else if (predict_valid) begin
            integer index = predict_pc ^ global_history;
            predict_taken <= (PHT[index] >= 2'b10);
            predict_history <= global_history;
        end
    end
    
endmodule
