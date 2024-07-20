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
    
    reg [6:0] BHR;
    reg [6:0] index;
    reg [1:0] PHT [0:127];
    
    assign predict_taken = PHT[index][1];
    assign predict_history = BHR;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            BHR <= 0;
            PHT <= 0;
        end else begin
            if (predict_valid) begin
                index <= predict_pc ^ BHR;
            end else if (train_valid) begin
                index <= train_pc ^ train_history;
                
                if (train_taken && train_history != 0) begin
                    PHT[index] <= PHT[index] + 1;
                end else if (!train_taken && train_history != 3) begin
                    PHT[index] <= PHT[index] - 1;
                end
                
                if (train_mispredicted) begin
                    BHR <= train_history;
                end
            end
        end
    end
    
endmodule
