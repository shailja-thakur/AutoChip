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

    reg [6:0] branch_history_reg;
    reg [6:0] index;
    reg [1:0] pht [0:127];
    reg [1:0] predict_state;
    reg [6:0] predict_pc_reg;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            branch_history_reg <= 7'b0;
            index <= 7'b0;
            predict_state <= 2'b0;
            predict_pc_reg <= 7'b0;
        end else begin
            if (train_valid) begin
                index <= train_history ^ train_pc;
                pht[index] <= pht[index] + 1;
                if (train_mispredicted) begin
                    branch_history_reg <= train_history;
                end
            end

            if (predict_valid && !train_valid) begin
                index <= predict_pc ^ branch_history_reg;
                predict_state <= pht[index];
                predict_taken <= (predict_state[1] == 2'b11);
                predict_history <= branch_history_reg;
                predict_pc_reg <= predict_pc;
            end

            if (predict_valid && train_valid) begin
                if (predict_pc != train_pc) begin
                    index <= predict_pc ^ branch_history_reg;
                    predict_state <= pht[index];
                    predict_taken <= (predict_state[1] == 2'b11);
                    predict_history <= branch_history_reg;
                    predict_pc_reg <= predict_pc;
                end else begin
                    predict_state <= pht[index];
                    predict_taken <= (predict_state[1] == 2'b11);
                    predict_history <= branch_history_reg;
                    predict_pc_reg <= predict_pc;
                end
            end
        end
    end

    always @(posedge clk) begin
        if (train_ valid)
            branch_history_reg <= {branch_history_reg[5:0], train_taken};
    end

    assign predict_taken = (predict_state[1] == 2'b11);
    assign predict_history = branch_history_reg;

endmodule
