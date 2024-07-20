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
    reg [6:0] predict_history_reg;
    reg [1:0] predict_table [0:127];

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 0;
            index <= 0;
            predict_history_reg <= 0;
            predict_taken <= 0;
            predict_history <= 0;
            predict_table <= 2'b00;
        end
        else if (predict_valid) begin
            index <= predict_pc ^ global_history;
            predict_taken <= (predict_table[index] == 2'b11) || (predict_table[index] == 2'b10);
            predict_history <= predict_history_reg;
        end
        else if (train_valid) begin
            index <= train_pc ^ train_history;
            if (predict_taken && train_mispredicted) begin
                predict_table[index] <= predict_table[index] - 2'b01;
            end else if (!predict_taken && !train_mispredicted) begin
                predict_table[index] <= predict_table[index] + 2'b01;
            end
            global_history <= {global_history[5:0], train_taken};
            predict_history_reg <= global_history;
        end
    end

endmodule
