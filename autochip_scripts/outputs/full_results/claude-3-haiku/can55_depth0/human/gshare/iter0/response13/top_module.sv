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

localparam PHT_SIZE = 128;
reg [1:0] pht[PHT_SIZE-1:0];
reg [6:0] global_history;

// Prediction logic
always @* begin
    if (predict_valid) begin
        // Hash PC and global history to get PHT index
        integer index = predict_pc ^ global_history;
        index = index[6:0];
        
        // Get prediction from PHT
        predict_taken = pht[index][1];
        predict_history = global_history;
    end else begin
        predict_taken = 0;
        predict_history = 0;
    end
end

// Training logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 0;
        for (integer i = 0; i < PHT_SIZE; i = i + 1) begin
            pht[i] <= 2'b10;
        end
    end else begin
        if (train_valid) begin
            // Hash PC and global history to get PHT index
            integer index = train_pc ^ train_history;
            index = index[6:0];
            
            // Update PHT based on branch outcome
            if (train_taken) begin
                pht[index] <= (pht[index] == 2'b11) ? 2'b11 : pht[index] + 1'b1;
            end else begin
                pht[index] <= (pht[index] == 2'b00) ? 2'b00 : pht[index] - 1'b1;
            end
            
            // Update global history
            global_history <= (train_taken) ? (global_history << 1) | 1'b1 : (global_history << 1);
            
            // Recover global history on misprediction
            if (train_mispredicted) begin
                global_history <= train_history;
            end
        end
    end
end

endmodule
