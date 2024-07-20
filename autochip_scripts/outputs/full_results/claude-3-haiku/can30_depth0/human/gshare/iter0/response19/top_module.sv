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

reg [1:0] pht [127:0];
reg [6:0] global_history;

// Prediction logic
wire [6:0] hash_pc = predict_pc ^ global_history;
always @(*) begin
    if (predict_valid) begin
        predict_taken = pht[hash_pc][1];
        predict_history = global_history;
    end else begin
        predict_taken = 0;
        predict_history = 0;
    end
end

// Training logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 0;
        for (int i = 0; i < 128; i++) begin
            pht[i] <= 2'b01;
        end
    end else begin
        if (train_valid) begin
            wire [6:0] hash_train_pc = train_pc ^ train_history;
            if (train_mispredicted) begin
                global_history <= train_history;
                pht[hash_train_pc] <= (train_taken) ? 2'b11 : 2'b00;
            end else begin
                global_history <= (train_taken) ? (global_history << 1) | 1 : (global_history << 1);
                pht[hash_train_pc] <= (train_taken) ? (pht[hash_train_pc] == 2'b11) ? 2'b11 : pht[hash_train_pc] + 1 :
                                                  (pht[hash_train_pc] == 2'b00) ? 2'b00 : pht[hash_train_pc] - 1;
            end
        end
    end
end

endmodule
