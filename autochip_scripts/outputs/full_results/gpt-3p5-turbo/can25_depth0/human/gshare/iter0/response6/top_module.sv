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

// Declare internal signals and registers
reg [6:0] global_history;
reg [6:0] index;
reg [1:0] pht [0:127];
reg [1:0] predict_outcome;
reg [1:0] train_outcome;
reg [6:0] train_history_reg;

// Initialize internal signals and registers
always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 0;
        index <= 0;
        for (integer i = 0; i < 128; i = i + 1) begin
            pht[i] <= 0;
        end
        predict_outcome <= 0;
        train_outcome <= 0;
        train_history_reg <= 0;
    end else begin
        global_history <= {global_history[5:0], predict_taken};
        index <= global_history ^ predict_pc;
        predict_outcome <= pht[index];
        train_outcome <= pht[index];
        train_history_reg <= train_history;
    end
end

// Connect prediction outputs
assign predict_taken = (predict_outcome == 2 || predict_outcome == 3);
assign predict_history = global_history;

// Train branch predictor
always @(posedge clk or posedge areset) begin
    if (areset) begin
        for (integer i = 0; i < 128; i = i + 1) begin
            pht[i] <= 0;
        end
    end else if (train_valid) begin
        pht[index] <= train_taken ? (pht[index] < 3) : (pht[index] > 0);
        if (train_mispredicted) begin
            global_history <= train_history_reg;
        end
    end
end

endmodule
