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

    reg [6:0] global_history;
    reg [6:0] index;
    
  	reg [6:0] pht_index;
  	reg [6:0] pht_index_train;
  	reg [1:0] pht[pht_index];
    
    // prediction interface
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_taken <= 0;
            predict_history <= 0;
        end else if (predict_valid) begin
            index = predict_pc ^ global_history;
            predict_taken <= pht[index][1];
            predict_history <= global_history;
        end
    end
    
    // training interface
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 0;
        end else if (train_valid) begin
            index = train_pc ^ train_history;
            pht_index_train = index;
            global_history <= (global_history << 1) | train_taken;
            
			if(train_mispredicted) begin
                pht[pht_index_train][1] <= 0;
    		end else begin
                pht[pht_index_train][1] <= 1;
    		end
    	end
    end
endmodule
