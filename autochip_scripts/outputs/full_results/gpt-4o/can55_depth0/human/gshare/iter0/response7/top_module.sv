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
    // Global branch history register
    reg [6:0] global_history;

    // Pattern history table (128 entries, 2-bit saturating counters)
    reg [1:0] PHT [0:127];

    // Indices for PHT
    wire [6:0] predict_index;
    wire [6:0] train_index;
    
    assign predict_index = predict_pc ^ global_history;
    assign train_index = train_pc ^ train_history;

    // Output predictions
    assign predict_taken = PHT[predict_index][1]; // Most significant bit of the counter
    assign predict_history = global_history;

    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;  
            integer i;
            // Initialize PHT entries to weakly not-taken (01)
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01;
            end
        end else begin
            // Training
            if (train_valid) begin
                // Update the saturating counter in the PHT
                if (train_taken) begin
                    if (PHT[train_index] != 2'b11) begin
                        PHT[train_index] <= PHT[train_index] + 1;
                    end
                end else begin
                    if (PHT[train_index] != 2'b00) begin
                        PHT[train_index] <= PHT[train_index] - 1;
                    end
                end

                // Recover the global history register in case of misprediction
                if (train_mispredicted) begin
                    global_history <= {train_history[5:0], train_taken};
                end else begin
                    // Update the global history register
                    if (predict_valid) begin
                        global_history <= {global_history[5:0], predict_taken};
                    end
                end
            end else if (predict_valid) begin
                // Update the global history register
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end
endmodule
