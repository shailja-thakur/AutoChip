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

// 7-bit PC and 7-bit global history hashed using XOR into a 7-bit index
reg [6:0] global_history;
wire [6:0] index = predict_pc ^ global_history;

// 128-entry table of 2-bit saturating counters
reg [1:0] pht[127:0];

always @(posedge clk or posedge areset) begin
    if (areset) begin
        predict_history <= 0;
        global_history <= 0;
        for (int i = 0; i < 128; i++) begin
            pht[i] <= 2'b01;
        end
    end
    else begin
        // Prediction
        if (predict_valid) begin
            predict_taken <= (pht[index] >= 2'b10);
            predict_history <= global_history;
        end

        // Training
        if (train_valid) begin
            // Update PHT
            if (train_taken)
                pht[index] <= (pht[index] == 2'b11) ? 2'b11 : pht[index] + 1'b1;
            else
                pht[index] <= (pht[index] == 2'b00) ? 2'b00 : pht[index] - 1'b1;

            // Update global history
            if (train_mispredicted)
                global_history <= train_history;
            else
                global_history <= {global_history[5:0], train_taken};
        end
    end
end

endmodule
