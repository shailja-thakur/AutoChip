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

localparam PHT_ENTRIES = 128;
localparam PHT_BITS = 2;

reg [PHT_BITS-1:0] pht[PHT_ENTRIES-1:0];
reg [6:0] global_history;

// Prediction Logic
wire [6:0] predict_index = predict_pc ^ global_history;
assign predict_taken = pht[predict_index][PHT_BITS-1];
assign predict_history = global_history;

// Training Logic
wire [6:0] train_index = train_pc ^ train_history;
always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 7'b0;
        for (int i = 0; i < PHT_ENTRIES; i++) begin
            pht[i] <= {PHT_BITS{1'b0}};
        end
    end
    else begin
        if (train_valid) begin
            // Update PHT
            if (train_taken) begin
                if (pht[train_index] != 2'b11)
                    pht[train_index] <= pht[train_index] + 1'b1;
            end
            else begin
                if (pht[train_index] != 2'b00)
                    pht[train_index] <= pht[train_index] - 1'b1;
            end

            // Update global history
            if (train_mispredicted) begin
                global_history <= train_history;
            end
            else begin
                global_history <= (global_history << 1) | train_taken;
            end
        end
        else if (predict_valid) begin
            // Update global history
            global_history <= (global_history << 1) | predict_taken;
        end
    end
end

endmodule
