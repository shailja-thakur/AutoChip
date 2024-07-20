module top_module(
    input wire clk,
    input wire areset,

    input wire predict_valid,
    input wire [6:0] predict_pc,
    output wire predict_taken,
    output wire [6:0] predict_history,

    input wire train_valid,
    input wire train_taken,
    input wire train_mispredicted,
    input wire [6:0] train_history,
    input wire [6:0] train_pc
);

reg [6:0] ghr;
reg [6:0] pht_index;
reg [1:0] pht_value;

wire [6:0] gh;
wire [6:0] pht_cnt_index;

// Hashing the pc and ghr to get pht index
xor u_hasher(
    .in_a({predict_pc[6:0], ghr[6:0]}),
    .out_hash(gh)
);

// Creating pht cnt index by concatenating pht index and ghr
assign pht_cnt_index = {gh, pht_index};

// 128-entry table of two-bit saturating counters
reg [1:0] pht_table [127:0];

always @(posedge clk or posedge areset) begin
    if (areset)
        pht_table <= 0;
    else if (train_valid) begin
        // Training for a branch
        pht_table[pht_cnt_index] <= (train_mispredicted) ? 
            ($signed(pht_table[pht_cnt_index]) == 0 ? 0 : $signed(pht_table[pht_cnt_index]) - 1) :
            ($signed(pht_table[pht_cnt_index]) == 3 ? 3 : $signed(pht_table[pht_cnt_index]) + 1);
    end
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        ghr <= 0;
        pht_index <= 0;
    end else if (predict_valid) begin
        // Prediction for a branch
        predict_taken <= pht_table[pht_cnt_index][1];
        predict_history <= ghr;
    end else if (train_valid) begin
        // Updating the branch history register
        ghr <= {ghr[5:0], train_taken};
        pht_index <= gh;
    end
end

endmodule
