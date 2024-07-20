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

    reg [1:0] PHT [0:127]; // 128-entry table of two-bit saturating counters
    reg [6:0] global_history; // 7-bit global branch history register

    integer i;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset all the PHT entries to weakly not taken (01) and clear the global history
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01;
            end
            global_history <= 7'b0;
        end else begin
            if (train_valid) begin
                // Calculate index using XOR of train_pc and train_history
                integer index;
                index = train_pc ^ train_history;
                
                // Update the PHT based on the true outcome
                if (train_taken) begin
                    if (PHT[index] < 2'b11)
                        PHT[index] <= PHT[index] + 1;
                end else begin
                    if (PHT[index] > 2'b00)
                        PHT[index] <= PHT[index] - 1;
                end

                // If mispredicted, recover the branch history register
                if (train_mispredicted) begin
                    global_history <= (global_history << 1) | train_taken;
                end else begin
                    global_history <= train_history;
                end
            end else if (predict_valid) begin
                // Update the global history with the prediction
                global_history <= (global_history << 1) | predict_taken;
            end
        end
    end

    always @(*) begin
        if (predict_valid) begin
            // Calculate index using XOR of predict_pc and current global history
            integer index;
            index = predict_pc ^ global_history;
            
            // Predict the branch direction based on PHT entry
            case (PHT[index])
                2'b00, 2'b01: predict_taken = 0; // Weakly or strongly not taken
                2'b10, 2'b11: predict_taken = 1; // Weakly or strongly taken
            endcase
            
            // Output the current global history register used to make the prediction
            predict_history = global_history;
        end
    end
endmodule
