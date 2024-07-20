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

    reg [6:0] pht_index;
    reg [1:0] pht_entry [0:127];
    reg [6:0] history_register;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            pht_index <= 0;
            pht_entry[0][0] <= 2'b00;
            history_register <= 0;
        end else if (predict_valid) begin
            pht_index <= predict_pc ^ history_register;
        end else if (train_valid) begin
            pht_index <= train_pc ^ train_history;
        end
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            pht_entry[0][1] <= 2'b00;
        end else if (train_valid && train_mispredicted) begin
            pht_entry[pht_index][1] <= pht_entry[pht_index][1] == 2'b00 ? 2'b00 : pht_entry[pht_index][1] - 1;
        end else if (train_valid) begin
            pht_entry[pht_index][1] <= pht_entry[pht_index][1] == 2'b11 ? 2'b11 : pht_entry[pht_index][1] + 1;
        end
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            pht_entry[0][0] <= 2'b00;
        end else if (train_valid && train_mispredicted) begin
            history_register <= train_history;
        end else if (train_valid) begin
            history_register <= {history_register[5:0], train_taken};
        end
    end

    assign predict_taken = pht_entry[pht_index][1] >= 2'b10;
    assign predict_history = history_register;

endmodule
