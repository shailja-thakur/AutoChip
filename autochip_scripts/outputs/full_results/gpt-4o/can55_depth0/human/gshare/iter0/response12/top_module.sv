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
    // Number of entries in the pattern history table
    localparam PHT_SIZE = 128;
    
    // Define the global history register
    reg [6:0] global_history;

    // Define the pattern history table
    reg [1:0] PHT [PHT_SIZE-1:0];
    
    // Index calculation using XOR of the PC and global history
    wire [6:0] predict_index = predict_pc ^ global_history;
    wire [6:0] train_index = train_pc ^ train_history;
    
    // Output prediction based on PHT entry
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Initialize global history and PHT on reset
            global_history <= 7'd0;
            for (integer i = 0; i < PHT_SIZE; i = i + 1) begin
                PHT[i] <= 2'b01; // Weakly not taken
            end
        end else begin
            if (predict_valid) begin
                // Make prediction
                predict_history <= global_history;
                case (PHT[predict_index])
                    2'b00, 2'b01: predict_taken <= 0; // Strongly/weakly not taken
                    2'b10, 2'b11: predict_taken <= 1; // Weakly/strongly taken
                    default: predict_taken <= 0; // Default case
                endcase
                
                // Update global history with outcome of the prediction
                global_history <= {global_history[5:0], predict_taken};
            end

            if (train_valid) begin
                // Update PHT based on actual branch outcome
                if (train_taken) begin
                    if (PHT[train_index] != 2'b11) begin
                        PHT[train_index] <= PHT[train_index] + 1;
                    end
                end else begin
                    if (PHT[train_index] != 2'b00) begin
                        PHT[train_index] <= PHT[train_index] - 1;
                    end
                end

                // If mispredicted, recover global history
                if (train_mispredicted) begin
                    global_history <= {train_history[6:1], train_taken};
                end else begin
                    if (train_valid && !train_mispredicted) begin
                        global_history <= {global_history[5:0], train_taken};
                    end
                end
            end
        end
    end
endmodule
