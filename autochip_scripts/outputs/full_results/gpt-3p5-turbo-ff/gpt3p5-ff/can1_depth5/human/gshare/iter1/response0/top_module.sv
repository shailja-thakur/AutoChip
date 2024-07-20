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

reg [6:0] history_register;
reg [6:0] index;
reg [1:0] counter [0:127];

 // Predict Branch Direction
always @(posedge clk or posedge areset) begin
    if (areset) begin
        history_register <= 0;
    end else if (predict_valid) begin
        index <= predict_pc ^ history_register;
    end
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        predict_taken <= 0;
        predict_history <= 0;
    end else begin
        predict_taken <= (counter[index] == 3 || counter[index] == 2);
        predict_history <= history_register;
    end
end

 // Train Branch Predictor
always @(posedge clk or posedge areset) begin
    if (areset) begin
        history_register <= 0;
    end else if (train_valid) begin
        index <= train_pc ^ train_history;
        
        if (train_mispredicted || counter[index] < 3) begin
            counter[index] <= counter[index] + 1;
        end else begin
            counter[index] <= counter[index] - 1;
        end
        
        if (train_taken) begin
            history_register <= {history_register[5:0], 1};
        end else begin
            history_register <= {history_register[5:0], 0};
        end
    end
end

endmodule
