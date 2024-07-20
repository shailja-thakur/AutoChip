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

    // Define constants
    localparam HISTORY_BITS = 7;
    localparam PHT_SIZE = 128;
    
    // Define data structures
    reg [1:0] PHT [0:PHT_SIZE-1]; // Pattern History Table with 2-bit saturating counters
    reg [HISTORY_BITS-1:0] GHR; // Global History Register

	// Initialize the pattern history table
    integer i;
    initial begin
        for (i = 0; i < PHT_SIZE; i = i + 1) begin
            PHT[i] = 2'b01; // Weakly not taken state
        end
    end

    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            GHR <= 7'b0;
            for (i = 0; i < PHT_SIZE; i = i + 1) begin
                PHT[i] <= 2'b01; // Weakly not taken state
            end
        end
        else begin
            if (train_valid) begin
                // Compute the index for the PHT
                reg [6:0] train_index;
                train_index = train_pc ^ train_history;

                // Update the PHT with the actual outcome
                if (train_taken) begin
                    if (PHT[train_index] < 2'b11) 
                        PHT[train_index] <= PHT[train_index] + 1;
                end else begin
                    if (PHT[train_index] > 2'b00) 
                        PHT[train_index] <= PHT[train_index] - 1;
                end
                
                // If mispredicted, recover the GHR to the state after the mispredicting branch
                if (train_mispredicted) begin
                    GHR <= {train_history, train_taken};
                end else begin
                    // Update the GHR for the next branch prediction
                    GHR <= {GHR[5:0], train_taken};
                end
            end
        end
    end

    always @(posedge clk) begin
        if (predict_valid && !train_valid) begin
            // Compute the index for the PHT
            reg [6:0] predict_index;
            predict_index = predict_pc ^ GHR;

            // Output the prediction
            predict_taken <= (PHT[predict_index] >= 2'b10);
            predict_history <= GHR;

            // Update the GHR for the predicted branch
            GHR <= {GHR[5:0], (PHT[predict_index] >= 2'b10)};
        end
    end
endmodule
