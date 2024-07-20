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

    reg [6:0] global_history;
    reg [1:0] PHT [127:0];

    // This procedure handles asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (integer i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Weakly not taken state
            end
        end else begin
            if (predict_valid) begin
	            if (train_valid && train_mispredicted) begin
	                global_history <= train_history;
	            end else begin
	                global_history <= {global_history[5:0], predict_taken};
	            end
	        end
	        if (train_valid) begin
	            integer index;
	            index = train_pc ^ train_history;
	            if (train_taken) begin
	                if (PHT[index] != 2'b11)
	                    PHT[index] <= PHT[index] + 1;
	            end else begin
	                if (PHT[index] != 2'b00)
	                    PHT[index] <= PHT[index] - 1;
	            end
	            if (train_mispredicted) begin
	                global_history <= {train_history[5:0], train_taken};
	            end
	        end
        end
    end

    always @(*) begin
        integer index;
        predict_history = global_history;
        if (predict_valid) begin
            index = predict_pc ^ global_history;
            case (PHT[index])
                2'b00, 2'b01: predict_taken = 0;
                2'b10, 2'b11: predict_taken = 1;
                default: predict_taken = 0; // Default case to avoid latches
            endcase
        end
    end
endmodule
