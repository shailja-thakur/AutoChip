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
    reg [1:0] counter [0:127];

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            index <= 7'b0;
            for (int i=0; i<128; i=i+1) begin
                counter[i] <= 2'b0;
            end
        end else begin
            if (train_valid && !train_mispredicted && (train_pc == predict_pc)) begin
                index <= train_history ^ predict_pc;
                predict_taken <= (counter[index] == 2'b10) ? 1'b1 : 1'b0;
                predict_history <= global_history[index];
            end else if (predict_valid) begin
                index <= global_history ^ predict_pc;
                predict_taken <= (counter[index] == 2'b10) ? 1'b1 : 1'b0;
                predict_history <= global_history[index];
            end
            if (clk) begin
                if (train_valid && (train_pc == predict_pc)) begin
                    counter[index] <= (train_taken) ? counter[index] + 1 : counter[index] - 1;
                end
                if (!train_valid) begin
                    global_history <= {train_mispredicted, global_history[5:0]};
                end
            end
        end
    end

endmodule
