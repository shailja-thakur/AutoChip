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

reg [6:0] g_sh;
reg [6:0] pht_index;
reg [1:0] pht_data [0:127];

reg [6:0] train_pc_reg;
reg train_taken_reg;
reg [6:0] train_history_reg;
reg train_mispredicted_reg;

assign predict_taken = pht_data[pht_index][1];
assign predict_history = g_sh;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        g_sh <= 7'b0;
        pht_index <= 7'b0;
        pht_data <= (128'b0);
    end else if (predict_valid) begin
        g_sh <= (g_sh << 1) | predict_taken;
        pht_index <= (g_sh ^ predict_pc) & 7'b1111111;
    end else if (train_valid) begin
        g_sh <= (g_sh << 1) | train_taken_reg;
        pht_index <= (g_sh ^ train_pc_reg) & 7'b1111111;
    end
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        pht_data <= (128'b0);
    end else if (predict_valid) begin
        pht_data[pht_index] <= (pht_data[pht_index] >> 2);
    end else if (train_valid) begin
        if (train_mispredicted_reg) begin
            pht_data[train_history_reg] <= (pht_data[train_history_reg] >> 2);
        end else begin
            pht_data[train_history_reg] <= (pht_data[train_history_reg] + 1) % 4;
        end
        train_pc_reg <= train_pc;
        train_taken_reg <= train_taken;
        train_history_reg <= train_history;
        train_mispredicted_reg <= train_mispredicted;
    end
end

endmodule
