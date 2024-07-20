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
    reg [1:0] prediction;
    reg [1:0] pht [127:0];
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 0;
            index <= 0;
            prediction <= 0;
            pht <= 0;
        end else begin
            if (predict_valid) begin
                index <= predict_pc ^ global_history;
                predict_taken <= pht[index][1];
                predict_history <= global_history;
            end
            if (train_valid) begin
                index <= train_pc ^ train_history;
                if (train_taken && train_mispredicted) begin
                    pht[index] <= {pht[index][0], 2'b11};
                    global_history <= train_history;
                end else if (train_taken && !train_mispredicted) begin
                    pht[index] <= {pht[index][0], 2'b11};
                    global_history <= {global_history[5:0], 1'b1};
                end else if (!train_taken && train_mispredicted) begin
                    pht[index] <= {pht[index][0], 2'b00};
                    global_history <= train_history;
                end else if (!train_taken && !train_mispredicted) begin
                    pht[index] <= {pht[index][0], 2'b00};
                    global_history <= {global_history[5:0], 1'b0};
                end
            end
        end
    end
    
endmodule
