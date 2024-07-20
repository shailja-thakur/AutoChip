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
    
    // 128-entry table of two-bit saturating counters
    reg [1:0] pht[127:0];

    // 7-bit global branch history register
    reg [6:0] global_history;
    
    integer i;

    // Asynchronous Reset
    always @(posedge areset or posedge clk) begin
        if (areset) begin
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                pht[i] <= 2'b01; // Initialize counters to weakly taken
            end
        end else if (clk) begin
            if (train_valid) begin
                integer index;
                index = train_pc ^ train_history;

                // Update PHT on training
                if (train_taken) begin
                    if (pht[index] != 2'b11)
                        pht[index] <= pht[index] + 1;
                end else begin
                    if (pht[index] != 2'b00)
                        pht[index] <= pht[index] - 1;
                end

                // Recover history register if mispredicted
                if (train_mispredicted)
                    global_history <= {global_history[5:0], train_taken};
            end else if (predict_valid) begin
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

    // Prediction logic
    always @(*) begin
        integer index;
        index = predict_pc ^ global_history;

        // Get prediction from PHT
        if (pht[index] >= 2'b10)
            predict_taken = 1;
        else
            predict_taken = 0;

        // Provide the prediction history
        predict_history = global_history;
    end
endmodule
