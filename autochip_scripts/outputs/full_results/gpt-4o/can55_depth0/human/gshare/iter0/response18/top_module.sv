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

    // Global history register
    reg [6:0] global_history;
    
    // Pattern history table (128 entries of 2-bit counters)
    reg [1:0] pht [127:0];
    
    // Reset logic
    integer i;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                pht[i] <= 2'b01; // Weakly not taken
            end
        end
    end
    
    wire [6:0] predict_index = predict_pc ^ global_history;
    wire [1:0] predict_counter = pht[predict_index];
    
    wire [6:0] train_index = train_pc ^ train_history;
    wire [1:0] train_counter = pht[train_index];

    // Prediction logic
    always @(posedge clk) begin
        if (predict_valid && !train_valid) begin
            predict_taken <= predict_counter[1];
            predict_history <= global_history;
            global_history <= {global_history[5:0], predict_counter[1]};
        end
    end
    
    // Training logic
    always @(posedge clk) begin
        if (train_valid) begin
            // Update PHT counter
            if (train_taken) begin
                if (train_counter < 2'b11)
                    pht[train_index] <= train_counter + 1;
            end else begin
                if (train_counter > 2'b00)
                    pht[train_index] <= train_counter - 1;
            end
            
            // Recover branch history register if mispredicted
            if (train_mispredicted)
                global_history <= {train_history[5:0], train_taken};
        end
    end

endmodule
