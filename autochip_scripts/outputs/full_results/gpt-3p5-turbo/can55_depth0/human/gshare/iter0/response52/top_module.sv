module gshare_branch_predictor(
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
reg [6:0] pht_index;
reg [1:0] pht_entry;

reg [6:0] train_pc_d;
reg [6:0] predict_pc_d;
reg [6:0] mispredict_pc;
reg [6:0] mispredict_pc_d;
reg mispredict_trigger;

reg [127:0] pht [0:127];
reg [1:0] pht_out;

always @(posedge clk or posedge areset) begin
    if(areset) begin
        history_register <= 0;
        pht_index <= 0;
        pht_entry <= 0;
        train_pc_d <= 0;
        predict_pc_d <= 0;
        mispredict_pc <= 0;
        mispredict_pc_d <= 0;
        mispredict_trigger <= 0;
    end else begin
        history_register <= {history_register[5:0], train_taken};
        pht_index <= {predict_pc[6:0], history_register[6:0]} ^ 7'b1111111;
        pht_entry <= pht[pht_index];
        train_pc_d <= train_pc;
        predict_pc_d <= predict_pc;
        mispredict_pc <= mispredict_trigger ? mispredict_pc_d : predict_pc;
        mispredict_pc_d <= mispredict_trigger ? 7'b0 : predict_pc_d;
        mispredict_trigger <= train_valid && train_mispredicted;
    end
end

always @(posedge clk) begin
    if(train_valid) begin
        pht_out <= pht_entry;
        pht[pht_index] <= train_taken ? $unsigned(pht_entry) + 1'b1 : ($unsigned(pht_entry) == 2'b00) ? 2'b00 : $unsigned(pht_entry) - 1'b1;
    end else begin
        pht_out <= 2'b10; // Weakly predict not taken
    end
end

assign predict_taken = (predict_valid && pht_out[1]) ? 1'b1 : 1'b0;
assign predict_history = history_register;

endmodule
